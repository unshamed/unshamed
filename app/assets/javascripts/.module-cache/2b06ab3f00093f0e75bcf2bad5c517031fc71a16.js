/**
 * @jsx React.DOM
 */

var UserMessage = React.createClass({displayName: "UserMessage",
  render: function() {
    var message = this.props.message;

    return (
      React.createElement("div", {className: "clearfix msg"}, 
        React.createElement("div", {className: "time"},  message.sentAt.toDate() ), 
        React.createElement("div", {className: "body"},  message.body)
      )
    );
  }
});

var Section = React.createClass({displayName: "Section",
  render: function() {
    var section = this.props.section;
    var messages = section.messages.map(function(message) {
      return (
        React.createElement(UserMessage, {message: message})
      );
    });

    return (
      React.createElement("li", {className: "clearfix section"}, 
        React.createElement("h4", {"ng-show": "section.newDay"},  section.timestamp.toDate() ), 

        React.createElement("div", {className: "profile-pic"}, 
          React.createElement("img", {src:  section.messages[0].sender.profile_pictures.square50})
        ), 

        React.createElement("div", {className: "msgs"}, 
         messages 
        )
      )
    );
  }
});

var ConversationList = React.createClass({displayName: "ConversationList",
  render: function() {
    var sections = this.props.sections.map(function(section) {
      return (
        React.createElement(Section, {section: section})
      );
    });

    return (
      React.createElement("ul", {className: "messages"}, 
        sections 
      )
    );
  }
});


angular.module('unshamed')
  .value('ConversationList', ConversationList);