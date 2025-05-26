/*/////////////////////////////////////////////////
 Clutter Types
/*/////////////////////////////////////////////////

private _smallJunk = [
	"Land_Garbage_square3_F",
	"Land_Garbage_square5_F",
	"Land_Garbage_line_F",
	"Land_GarbageBarrel_02_buried_F",
	"Land_Tyre_F",
	"Land_FlowerPot_01_F",
	"Land_Bucket_painted_F",
	"Land_ButaneCanister_F",
	"Land_Matches_F",
	"Land_PlasticBucket_01_open_F",
	"Land_PlasticBucket_01_closed_F",
	"Land_MoneyBills_01_bunch_F",
	"Land_MultiMeter_F",
	"Tire_Van_02_F",
	"Land_BottlePlastic_V1_F",
	"Land_Can_Dented_F",
	"Land_BakedBeans_F",
	"Land_CerealsBox_F",
	"Land_GasTank_01_blue_F",
	"Land_CanisterFuel_White_F",
	"Land_CanisterFuel_Red_F",
	"Land_CanisterFuel_F"
];

private _mediumJunk = [
	"Land_GarbageBags_F",
	"Land_GarbageBarrel_02_F",
	"Land_GarbageBarrel_01_english_F",
	"Land_GarbagePallet_F",
	"Land_GarbageHeap_04_F",
	"Land_GarbageHeap_03_F",
	"Land_GarbageHeap_02_F",
	"Land_GarbageWashingMachine_F",
	"Land_Tyres_F"
];

private _largeJunk = [

];

private _smallSports = [
	"Land_Baseball_01_F",
	"Land_BaseballMitt_01_F",
	"Land_Basketball_01_F",
	"Land_Football_01_F",
	"Land_Rugbyball_01_F",
	"Land_Volleyball_01_F"
];


private _mediumConstruction = [
	"Land_CinderBlocks_01_F",
	"Land_Pallets_stack_F",
	"Land_Pallets_F"
];

private _largeConstruction = [
	"Land_IronPipes_F",
	"Land_TimberPile_05_F",
	"Land_WoodenPlanks_01_messy_pine_F"
];

private _smallElectronics = [
	"Land_CarBattery_02_F",
	"Land_Microwave_01_F",
	"Land_FMradio_F"
];

private _mediumWrecks = [

];

private _largeWrecks = [
	"Land_Wreck_BRDM2_F",
	"Land_Wreck_BMP2_F",
	"Land_V3S_wreck_F",
	"Land_Wreck_T72_hull_F",
	"Land_Wreck_Car2_F",
	"Land_Wreck_Offroad2_F",
	"Land_Wreck_UAZ_F",
	"Land_ScrapHeap_2_F",
	"Land_ScrapHeap_1_F"
];



private _largeVehicles = [
	"C_Offroad_01_F"
];

/*/////////////////////////////////////////////////
 Compile clutter
/*/////////////////////////////////////////////////

LND_iedd_smallClutter = _smallJunk + _smallSports + _smallElectronics;
LND_iedd_mediumClutter = _mediumJunk + _mediumWrecks + _mediumConstruction;
LND_iedd_largeClutter = _largeJunk + _largeWrecks + _largeConstruction + _largeVehicles;