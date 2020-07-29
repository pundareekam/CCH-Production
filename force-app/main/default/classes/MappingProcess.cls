public without sharing class MappingProcess {

	public String ProcessName {get;set;}

	public String FromObject {get;set;}
	public String ToObject {get;set;}
	
	private Set<String> fromPossibles {get;set;}
	private Set<String> toPossibles {get;set;}

	//         FROM,  TO
	public Map<String,String> FieldMappings {get{
		if(FieldMappings == null) FieldMappings = new Map<String,String>();
		return FieldMappings;
	}set;}

	public void addMapping(Field_Mapping__mdt fm) {
		String fixedFromName = MappingUtil.normalizeProcessName(fm.From_Field__c);
		String fixedToName = MappingUtil.normalizeProcessName(fm.To_Field__c);
		if(fromPossibles.contains(fixedFromName) && toPossibles.contains(fixedToName)) {
			FieldMappings.put(fm.From_Field__c,fm.To_Field__c);
		} else {
			System.debug(
				(!fromPossibles.contains(fm.From_Field__c) ? fm.From_Field__c + ' is not a field on ' + FromObject + '\n' : '') +
				(!fromPossibles.contains(fm.To_Field__c) ? fm.To_Field__c + ' is not a field on ' + ToObject : '')
			);
		}
	}

	public MappingProcess(String procName,Field_Mapping__mdt fm) {
		ProcessName = procName;
		fromPossibles = getFieldMap(fm.From_Object__c).keySet();
		toPossibles = getFieldMap(fm.To_Object__c).keySet();
		FromObject = fm.From_Object__c;
		ToObject = fm.To_Object__c;
		addMapping(fm);
	}

	public static Map<String,SObjectField> getFieldMap(String sObjectName) {
		return Schema.getGlobalDescribe().get(sObjectName).getDescribe().fields.getMap();
	}

	public MappingProcess(String x_ProcessName) {
		ProcessName = x_ProcessName;
	}

	public String grabFromBaseQuery() {
		return makeQuery(new Set<String>(FieldMappings.keySet()), FromObject);
	}

	public String grabToBaseQuery() {
		return makeQuery(new Set<String>(FieldMappings.values()), ToObject);
	}

	private String makeQuery(Set<String> fields,String objName) {
		fields.add('Id');
		return 'SELECT ' + String.join(new List<String>(fields), ', ') + ' FROM ' + objName + ' WHERE ';
	}
}