import Group from "discourse/models/group";

export default{
  setupComponent(){
    // Hack as {{group-selector}} accepts a comma-separated string as data source, but
    // we use an array to populate the datasource above.
    const groupsFilter = this.get("model.custom_fields.autoresponder_groups");
    const groupNames = typeof groupsFilter === "string" ? groupsFilter.split(",") : groupsFilter;

     this.set("model.custom_fields.autoresponder_groups",groupNames);

    this.set("userGroupFinder",function(term){
      return Group.findAll({ term: term, ignore_automatic: false });
    });
  }
}
