import {
  default as computed,
  observes,
  on
} from "ember-addons/ember-computed-decorators";

export default Ember.Component.extend({
  inputTime: null,
  inputDate: null,
  utcTime: null,

  @on("didInsertElement")
  setInputTime(){
    let date = new Date(this.get("utcTime"));
    if (date.toString().slice(0,1) != "I") {
      this.set("inputDate", date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate());
      let time = date.toTimeString().slice(0,5);
      this.set("inputTime", time);
    }
  },

  // convert the time to UTC
  @observes("inputTime","inputDate")
  timeChanged(){
    let date = new Date(this.get('inputDate') + " " + this.get('inputTime'));
    if (date.toString().slice(0,1) != "I") {
      this.set("utcTime",date.toUTCString());
    }else{
      this.set("utcTime",null);
    }
  },


});
