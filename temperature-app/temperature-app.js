if (Meteor.isClient) {
  // counter starts at 0
  Session.setDefault('counter', 0);

  Template.hello.helpers({
    counter: function () {
      return Session.get('counter');
    },
    temperature: function() {
      Meteor.call(get_temp, function(error, res) {
        return res;
      })
    },
    humidity: function() {
      Meteor.call(get_humi, function(error, res) {
        return res;
      })
    }
  });

  Template.hello.events({
    'click button': function () {
      // increment the counter when button is clicked
      Session.set('counter', Session.get('counter') + 1);
    }
  });
}

if (Meteor.isServer) {
  var client = mqtt.connect([{host:'192.168.1.5', port: 1883}]);

  Temperatures = new Mongo.Collection('temperatures');
  
  Meteor.startup(function () {

    console.log('meteor è partito')

    client.on('connect', function () {
      console.log('Meteor si è collegato')
      client.subscribe('humidity');
      client.subscribe('temperature');
    })
    
    client.on('message', function (topic, message) {
      if (topic == 'temperature') {
        Temperatures.insert({
          value: message
        });
      }
    })

  });

  Meteor.methods({
    get_temp: function() {
      Temperatures.find();
    },

    get_humi: function() {
    }
  })
}
