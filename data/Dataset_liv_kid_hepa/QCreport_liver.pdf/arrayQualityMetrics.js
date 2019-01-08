// (C) Wolfgang Huber 2010-2011

// Script parameters - these are set up by R in the function 'writeReport' when copying the 
//   template for this script from arrayQualityMetrics/inst/scripts into the report.

var highlightInitial = [ false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, true, false, true, false, false, false, false, false, false, false, false, false, false, true, false, true, false, false, false, false, false, false, true, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, true, false, false, false, false, false, false, false, false, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
var arrayMetadata    = [ [ "1", "GSM1392188_92992.CEL.gz", "1", "11/22/05 15:26:12" ], [ "2", "GSM1392189_92993.CEL.gz", "2", "11/29/05 14:57:54" ], [ "3", "GSM1392190_92994.CEL.gz", "3", "11/30/05 15:05:53" ], [ "4", "GSM1392191_94109.CEL.gz", "4", "01/10/06 10:54:06" ], [ "5", "GSM1392286_94244.CEL.gz", "5", "01/12/06 09:20:42" ], [ "6", "GSM1392287_94245.CEL.gz", "6", "01/12/06 11:42:07" ], [ "7", "GSM1392288_94246.CEL.gz", "7", "01/12/06 11:49:38" ], [ "8", "GSM1392292_94250.CEL.gz", "8", "01/12/06 11:05:44" ], [ "9", "GSM1392298_94256.CEL.gz", "9", "01/12/06 11:04:58" ], [ "10", "GSM1392308_94266.CEL.gz", "10", "01/12/06 13:10:36" ], [ "11", "GSM1392323_94281.CEL.gz", "11", "01/12/06 15:23:17" ], [ "12", "GSM1392324_94282.CEL.gz", "12", "01/12/06 15:30:42" ], [ "13", "GSM1392328_94286.CEL.gz", "13", "01/12/06 15:02:19" ], [ "14", "GSM1392340_94298.CEL.gz", "14", "01/13/06 09:29:36" ], [ "15", "GSM1392344_94302.CEL.gz", "15", "01/13/06 09:59:24" ], [ "16", "GSM1392389_94361.CEL.gz", "16", "01/18/06 09:51:11" ], [ "17", "GSM1392420_94396.CEL.gz", "17", "01/18/06 09:06:29" ], [ "18", "GSM1392423_94399.CEL.gz", "18", "01/18/06 13:11:50" ], [ "19", "GSM1392425_94401.CEL.gz", "19", "01/17/06 09:59:02" ], [ "20", "GSM1392434_94410.CEL.gz", "20", "01/18/06 15:00:06" ], [ "21", "GSM1392477_94458.CEL.gz", "21", "01/24/06 13:19:08" ], [ "22", "GSM1392499_94487.CEL.gz", "22", "01/25/06 09:16:34" ], [ "23", "GSM1392575_94565.CEL.gz", "23", "01/27/06 09:29:47" ], [ "24", "GSM1392577_94567.CEL.gz", "24", "01/27/06 10:59:53" ], [ "25", "GSM1392578_94568.CEL.gz", "25", "01/27/06 11:07:07" ], [ "26", "GSM1392609_94602.CEL.gz", "26", "02/01/06 12:36:07" ], [ "27", "GSM1392624_94657.CEL.gz", "27", "02/02/06 08:47:46" ], [ "28", "GSM1392663_94708.CEL.gz", "28", "02/03/06 09:33:09" ], [ "29", "GSM1392682_94731.CEL.gz", "29", "02/02/06 10:41:15" ], [ "30", "GSM1392689_94738.CEL.gz", "30", "02/03/06 10:50:39" ], [ "31", "GSM1392713_94767.CEL.gz", "31", "02/03/06 14:54:42" ], [ "32", "GSM1392733_94800.CEL.gz", "32", "02/06/06 09:05:06" ], [ "33", "GSM1392771_94924.CEL.gz", "33", "02/07/06 09:03:33" ], [ "34", "GSM1392925_95147.CEL.gz", "34", "01/31/06 08:50:18" ], [ "35", "GSM1392938_95164.CEL.gz", "35", "02/15/06 09:16:05" ], [ "36", "GSM1392943_95171.CEL.gz", "36", "02/15/06 10:52:58" ], [ "37", "GSM1392957_95213.CEL.gz", "37", "02/15/06 11:23:59" ], [ "38", "GSM1392978_95266.CEL.gz", "38", "02/10/06 11:31:48" ], [ "39", "GSM1392981_95271.CEL.gz", "39", "02/10/06 11:39:21" ], [ "40", "GSM1392992_95295.CEL.gz", "40", "02/10/06 15:11:41" ], [ "41", "GSM1393002_95321.CEL.gz", "41", "02/15/06 09:31:03" ], [ "42", "GSM1393006_95334.CEL.gz", "42", "02/28/06 11:31:06" ], [ "43", "GSM1393010_95341.CEL.gz", "43", "02/15/06 15:18:31" ], [ "44", "GSM1393015_95351.CEL.gz", "44", "02/16/06 08:47:37" ], [ "45", "GSM1393032_95374.CEL.gz", "45", "02/28/06 12:47:42" ], [ "46", "GSM1393046_95401.CEL.gz", "46", "02/16/06 09:17:56" ], [ "47", "GSM1393059_95427.CEL.gz", "47", "02/16/06 11:07:29" ], [ "48", "GSM1393085_95478.CEL.gz", "48", "02/16/06 12:50:54" ], [ "49", "GSM1393112_95524.CEL.gz", "49", "02/15/06 13:11:09" ], [ "50", "GSM1393116_95535.CEL.gz", "50", "02/15/06 12:41:34" ], [ "51", "GSM1393121_95547.CEL.gz", "51", "02/15/06 13:18:58" ], [ "52", "GSM1393131_95570.CEL.gz", "52", "02/15/06 15:18:33" ], [ "53", "GSM1393138_95598.CEL.gz", "53", "02/15/06 14:56:36" ], [ "54", "GSM1393166_95626.CEL.gz", "54", "02/08/06 11:54:52" ], [ "55", "GSM1393182_95643.CEL.gz", "55", "02/08/06 08:49:13" ], [ "56", "GSM1393203_95706.CEL.gz", "56", "02/17/06 12:51:22" ], [ "57", "GSM1393212_95715.CEL.gz", "57", "02/17/06 12:59:38" ], [ "58", "GSM1393243_95746.CEL.gz", "58", "02/17/06 11:33:57" ], [ "59", "GSM1393250_95753.CEL.gz", "59", "02/17/06 11:26:00" ], [ "60", "GSM1393266_95769.CEL.gz", "60", "02/22/06 10:44:31" ], [ "61", "GSM1393269_95772.CEL.gz", "61", "02/22/06 11:07:08" ], [ "62", "GSM1393274_95777.CEL.gz", "62", "02/22/06 10:44:57" ], [ "63", "GSM1393276_95779.CEL.gz", "63", "02/22/06 11:00:06" ], [ "64", "GSM1393293_95797.CEL.gz", "64", "02/22/06 08:57:08" ], [ "65", "GSM1393297_95801.CEL.gz", "65", "02/22/06 09:26:50" ], [ "66", "GSM1393306_95812.CEL.gz", "66", "02/22/06 13:17:48" ], [ "67", "GSM1393309_95816.CEL.gz", "67", "02/22/06 14:42:33" ], [ "68", "GSM1393314_95822.CEL.gz", "68", "02/22/06 14:28:14" ], [ "69", "GSM1393316_95824.CEL.gz", "69", "02/22/06 14:43:24" ], [ "70", "GSM1393337_95845.CEL.gz", "70", "02/23/06 09:25:34" ], [ "71", "GSM1393344_95852.CEL.gz", "71", "02/23/06 11:13:12" ], [ "72", "GSM1393359_95868.CEL.gz", "72", "02/23/06 13:10:19" ], [ "73", "GSM1393376_95888.CEL.gz", "73", "02/23/06 14:47:57" ], [ "74", "GSM1393394_95906.CEL.gz", "74", "02/24/06 10:34:28" ], [ "75", "GSM1393424_95937.CEL.gz", "75", "02/24/06 14:54:55" ], [ "76", "GSM1393449_95989.CEL.gz", "76", "03/01/06 09:27:29" ], [ "77", "GSM1393458_95998.CEL.gz", "77", "03/01/06 11:24:27" ], [ "78", "GSM1393462_96002.CEL.gz", "78", "03/01/06 11:03:49" ], [ "79", "GSM1393464_96004.CEL.gz", "79", "03/01/06 11:26:07" ], [ "80", "GSM1393471_96011.CEL.gz", "80", "03/01/06 13:06:33" ], [ "81", "GSM1393476_96024.CEL.gz", "81", "03/01/06 10:48:42" ], [ "82", "GSM1393477_96025.CEL.gz", "82", "03/01/06 11:18:44" ], [ "83", "GSM1393480_96028.CEL.gz", "83", "03/01/06 12:36:30" ], [ "84", "GSM1393482_96030.CEL.gz", "84", "03/01/06 12:59:03" ], [ "85", "GSM1393483_96031.CEL.gz", "85", "03/01/06 13:14:13" ], [ "86", "GSM1393485_96033.CEL.gz", "86", "03/01/06 14:29:26" ], [ "87", "GSM1393488_96036.CEL.gz", "87", "03/01/06 14:30:23" ], [ "88", "GSM1393509_96058.CEL.gz", "88", "03/02/06 09:24:57" ], [ "89", "GSM1393530_96079.CEL.gz", "89", "03/02/06 13:10:30" ], [ "90", "GSM1393532_96081.CEL.gz", "90", "03/02/06 13:25:25" ], [ "91", "GSM1393557_96106.CEL.gz", "91", "03/02/06 15:15:46" ], [ "92", "GSM1393566_96115.CEL.gz", "92", "03/03/06 08:56:25" ], [ "93", "GSM1393626_96178.CEL.gz", "93", "03/07/06 15:20:35" ], [ "94", "GSM1393655_96208.CEL.gz", "94", "03/08/06 09:13:52" ], [ "95", "GSM1393658_96211.CEL.gz", "95", "03/08/06 08:51:15" ], [ "96", "GSM1393852_96490.CEL.gz", "96", "03/16/06 11:00:38" ], [ "97", "GSM1393859_96497.CEL.gz", "97", "03/16/06 10:52:21" ], [ "98", "GSM1393885_96523.CEL.gz", "98", "03/16/06 15:16:55" ], [ "99", "GSM1393892_96530.CEL.gz", "99", "03/16/06 15:09:26" ], [ "100", "GSM1393905_96543.CEL.gz", "100", "03/17/06 08:52:04" ], [ "101", "GSM1393941_96580.CEL.gz", "101", "03/17/06 14:54:17" ], [ "102", "GSM1393950_96589.CEL.gz", "102", "03/17/06 14:47:24" ], [ "103", "GSM1393954_96593.CEL.gz", "103", "03/17/06 15:16:58" ], [ "104", "GSM1393983_96625.CEL.gz", "104", "03/21/06 16:37:22" ], [ "105", "GSM1393989_96631.CEL.gz", "105", "03/22/06 09:13:52" ], [ "106", "GSM1393998_96643.CEL.gz", "106", "03/21/06 10:09:13" ], [ "107", "GSM1394010_96657.CEL.gz", "107", "03/21/06 11:58:13" ], [ "108", "GSM1394028_96694.CEL.gz", "108", "03/22/06 10:41:41" ], [ "109", "GSM1394038_96704.CEL.gz", "109", "03/22/06 12:59:13" ], [ "110", "GSM1394040_96706.CEL.gz", "110", "03/22/06 13:13:58" ], [ "111", "GSM1394059_96727.CEL.gz", "111", "03/22/06 14:40:58" ], [ "112", "GSM1394061_96729.CEL.gz", "112", "03/22/06 14:56:01" ], [ "113", "GSM1394070_96738.CEL.gz", "113", "03/23/06 13:01:25" ], [ "114", "GSM1394092_96761.CEL.gz", "114", "03/23/06 08:59:45" ], [ "115", "GSM1394097_96766.CEL.gz", "115", "03/23/06 09:37:31" ], [ "116", "GSM1394125_96867.CEL.gz", "116", "03/24/06 09:20:24" ], [ "117", "GSM1394130_96875.CEL.gz", "117", "03/24/06 08:35:09" ], [ "118", "GSM1394169_97533.CEL.gz", "118", "04/28/06 15:16:05" ], [ "119", "GSM1394175_97539.CEL.gz", "119", "04/28/06 15:01:21" ], [ "120", "GSM1394208_97583.CEL.gz", "120", "04/28/06 10:55:52" ], [ "121", "GSM1394216_97592.CEL.gz", "121", "04/27/06 08:49:28" ], [ "122", "GSM1394217_97593.CEL.gz", "122", "04/28/06 10:56:33" ], [ "123", "GSM1394282_97677.CEL.gz", "123", "04/26/06 13:07:30" ], [ "124", "GSM1394287_97682.CEL.gz", "124", "04/25/06 10:49:17" ], [ "125", "GSM1394303_97698.CEL.gz", "125", "04/25/06 13:11:05" ], [ "126", "GSM1394355_97767.CEL.gz", "126", "04/26/06 12:22:53" ], [ "127", "GSM1394374_97787.CEL.gz", "127", "04/26/06 14:57:08" ], [ "128", "GSM1394389_97998.CEL.gz", "128", "05/02/06 14:17:27" ] ];
var svgObjectNames   = [ "pca", "dens" ];

var cssText = ["stroke-width:1; stroke-opacity:0.4",
               "stroke-width:3; stroke-opacity:1" ];

// Global variables - these are set up below by 'reportinit'
var tables;             // array of all the associated ('tooltips') tables on the page
var checkboxes;         // the checkboxes
var ssrules;


function reportinit() 
{
 
    var a, i, status;

    /*--------find checkboxes and set them to start values------*/
    checkboxes = document.getElementsByName("ReportObjectCheckBoxes");
    if(checkboxes.length != highlightInitial.length)
	throw new Error("checkboxes.length=" + checkboxes.length + "  !=  "
                        + " highlightInitial.length="+ highlightInitial.length);
    
    /*--------find associated tables and cache their locations------*/
    tables = new Array(svgObjectNames.length);
    for(i=0; i<tables.length; i++) 
    {
        tables[i] = safeGetElementById("Tab:"+svgObjectNames[i]);
    }

    /*------- style sheet rules ---------*/
    var ss = document.styleSheets[0];
    ssrules = ss.cssRules ? ss.cssRules : ss.rules; 

    /*------- checkboxes[a] is (expected to be) of class HTMLInputElement ---*/
    for(a=0; a<checkboxes.length; a++)
    {
	checkboxes[a].checked = highlightInitial[a];
        status = checkboxes[a].checked; 
        setReportObj(a+1, status, false);
    }

}


function safeGetElementById(id)
{
    res = document.getElementById(id);
    if(res == null)
        throw new Error("Id '"+ id + "' not found.");
    return(res)
}

/*------------------------------------------------------------
   Highlighting of Report Objects 
 ---------------------------------------------------------------*/
function setReportObj(reportObjId, status, doTable)
{
    var i, j, plotObjIds, selector;

    if(doTable) {
	for(i=0; i<svgObjectNames.length; i++) {
	    showTipTable(i, reportObjId);
	} 
    }

    /* This works in Chrome 10, ssrules will be null; we use getElementsByClassName and loop over them */
    if(ssrules == null) {
	elements = document.getElementsByClassName("aqm" + reportObjId); 
	for(i=0; i<elements.length; i++) {
	    elements[i].style.cssText = cssText[0+status];
	}
    } else {
    /* This works in Firefox 4 */
    for(i=0; i<ssrules.length; i++) {
        if (ssrules[i].selectorText == (".aqm" + reportObjId)) {
		ssrules[i].style.cssText = cssText[0+status];
		break;
	    }
	}
    }

}

/*------------------------------------------------------------
   Display of the Metadata Table
  ------------------------------------------------------------*/
function showTipTable(tableIndex, reportObjId)
{
    var rows = tables[tableIndex].rows;
    var a = reportObjId - 1;

    if(rows.length != arrayMetadata[a].length)
	throw new Error("rows.length=" + rows.length+"  !=  arrayMetadata[array].length=" + arrayMetadata[a].length);

    for(i=0; i<rows.length; i++) 
 	rows[i].cells[1].innerHTML = arrayMetadata[a][i];
}

function hideTipTable(tableIndex)
{
    var rows = tables[tableIndex].rows;

    for(i=0; i<rows.length; i++) 
 	rows[i].cells[1].innerHTML = "";
}


/*------------------------------------------------------------
  From module 'name' (e.g. 'density'), find numeric index in the 
  'svgObjectNames' array.
  ------------------------------------------------------------*/
function getIndexFromName(name) 
{
    var i;
    for(i=0; i<svgObjectNames.length; i++)
        if(svgObjectNames[i] == name)
	    return i;

    throw new Error("Did not find '" + name + "'.");
}


/*------------------------------------------------------------
  SVG plot object callbacks
  ------------------------------------------------------------*/
function plotObjRespond(what, reportObjId, name)
{

    var a, i, status;

    switch(what) {
    case "show":
	i = getIndexFromName(name);
	showTipTable(i, reportObjId);
	break;
    case "hide":
	i = getIndexFromName(name);
	hideTipTable(i);
	break;
    case "click":
        a = reportObjId - 1;
	status = !checkboxes[a].checked;
	checkboxes[a].checked = status;
	setReportObj(reportObjId, status, true);
	break;
    default:
	throw new Error("Invalid 'what': "+what)
    }
}

/*------------------------------------------------------------
  checkboxes 'onchange' event
------------------------------------------------------------*/
function checkboxEvent(reportObjId)
{
    var a = reportObjId - 1;
    var status = checkboxes[a].checked;
    setReportObj(reportObjId, status, true);
}


/*------------------------------------------------------------
  toggle visibility
------------------------------------------------------------*/
function toggle(id){
  var head = safeGetElementById(id + "-h");
  var body = safeGetElementById(id + "-b");
  var hdtxt = head.innerHTML;
  var dsp;
  switch(body.style.display){
    case 'none':
      dsp = 'block';
      hdtxt = '-' + hdtxt.substr(1);
      break;
    case 'block':
      dsp = 'none';
      hdtxt = '+' + hdtxt.substr(1);
      break;
  }  
  body.style.display = dsp;
  head.innerHTML = hdtxt;
}
