// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require bootstrap-sprockets
//= require popper
//= require moment
//= require moment/ja.js
//= require_tree .





$(document).ready(function() {
  "use strict";
  // ------------------------------------------------------- //
  // Calendar
  // ------------------------------------------------------ //
  $(function () {
    // page is ready
    $("#calendar").fullCalendar({
      themeSystem: "bootstrap4",
      // emphasizes business hours
      businessHours: false,
      defaultView: "month",
      // event dragging & resizing
      editable: true,
      events: "/events.json",
      selectHelper: true,
      selectable: true,
      ignoreTimezone: false,
      // header
      header: {
        left: "title",
        center: "month,agendaWeek,agendaDay",
        right: "today prev,next",
      },
      events: [
        {
          title: "Barber",
          description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
          start: "2019-07-07",
          end: "2019-07-07",
          className: "fc-bg-default",
          icon: "circle",
        },
        {
          title: "Flight Paris",
          description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
          start: "2019-08-08T14:00:00",
          end: "2019-08-08T20:00:00",
          className: "fc-bg-deepskyblue",
          icon: "cog",
          allDay: false,
        },
        {
          title: "Team Meeting",
          description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
          start: "2019-07-10T13:00:00",
          end: "2019-07-10T16:00:00",
          className: "fc-bg-pinkred",
          icon: "group",
          allDay: false,
        },
        {
          title: "Meeting",
          description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
          start: "2019-08-12",
          className: "fc-bg-lightgreen",
          icon: "suitcase",
        },
        {
          title: "Conference",
          description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
          start: "2019-08-13",
          end: "2019-08-15",
          className: "fc-bg-blue",
          icon: "calendar",
        },
        {
          title: "Baby Shower",
          description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
          start: "2019-08-13",
          end: "2019-08-14",
          className: "fc-bg-default",
          icon: "child",
        },
        {
          title: "Birthday",
          description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
          start: "2019-09-13",
          end: "2019-09-14",
          className: "fc-bg-default",
          icon: "birthday-cake",
        },
        {
          title: "Restaurant",
          description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
          start: "2019-10-15T09:30:00",
          end: "2019-10-15T11:45:00",
          className: "fc-bg-default",
          icon: "glass",
          allDay: false,
        },
        {
          title: "Dinner",
          description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
          start: "2019-11-15T20:00:00",
          end: "2019-11-15T22:30:00",
          className: "fc-bg-default",
          icon: "cutlery",
          allDay: false,
        },
        {
          title: "Shooting",
          description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
          start: "2019-08-25",
          end: "2019-08-25",
          className: "fc-bg-blue",
          icon: "camera",
        },
        {
          title: "Go Space :)",
          description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
          start: "2019-12-27",
          end: "2019-12-27",
          className: "fc-bg-default",
          icon: "rocket",
        },
        {
          title: "Dentist",
          description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
          start: "2019-12-29T11:30:00",
          end: "2019-12-29T012:30:00",
          className: "fc-bg-blue",
          icon: "medkit",
          allDay: false,
        },
        {
          title: "Dentist",
          description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eu pellentesque nibh. In nisl nulla, convallis ac nulla eget, pellentesque pellentesque magna.",
          start: "2020-06-27T11:30:00",
          end: "2020-06-28T012:30:00",
          className: "fc-bg-blue",
          icon: "medkit",
          allDay: false,
        },
      ],
      eventRender: function (event, element) {
        if (event.icon) {
          element
            .find(".fc-title")
            .prepend("<i class='fa fa-" + event.icon + "'></i>");
        }
      },
      select: function (start, end) {
        $.getScript("/events/new", function () {
          $("#datetimepicker7").datetimepicker();
          $("#datetimepicker8").datetimepicker({
            useCurrent: true,
            format: true,
            defaultDate: true,
          });
          $("#datetimepicker7").on("change.datetimepicker", function (e, start, end) {
            $("#datetimepicker8").datetimepicker("start", e.date);
            $(".start_hidden").val(moment(start).format("YYYY-MM-DD HH:mm"));
          });
          $("#datetimepicker8").on("change.datetimepicker", function (e) {
            $("#datetimepicker7").datetimepicker("end", e.date);
            $(".end_hidden").val(moment(end).format("YYYY-MM-DD HH:mm"));
          });
        });

        calendar.fullCalendar("unselect");
      },

      eventClick: function (event, jsEvent, view) {
        jQuery(".event-icon").html("<i class='fa fa-" + event.icon + "'></i>");
        jQuery(".event-title").html(event.title);
        jQuery(".event-body").html(event.description);
        jQuery(".eventUrl").attr("href", event.url);
        jQuery("#modal-view-event").modal();
      },
    });
  });

  $(document).ready(function () {
    var select = function (start, end, allDay) {
      var title = window.prompt("title");
      var data = {
        event: {
          title: title,
          start: start.format(),
          end: end.format(),
          allDay: allDay,
        },
      };
      $.ajax({
        type: "POST",
        url: "/events",
        data: data,

        success: function () {
          calendar.fullCalendar("refetchEvents");
        },
      });
      calendar.fullCalendar("unselect");
    };

  });
});


