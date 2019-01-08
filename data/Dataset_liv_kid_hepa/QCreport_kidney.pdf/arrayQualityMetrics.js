// (C) Wolfgang Huber 2010-2011

// Script parameters - these are set up by R in the function 'writeReport' when copying the 
//   template for this script from arrayQualityMetrics/inst/scripts into the report.

var highlightInitial = [ false, false, false, false, false, false, false, false, true, false, false, true, false, true, false, true, false, false, false, false, false, false, false, true, false, true, false, false, false, false, false, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, true, true, false, false, false, false, false, false, false, true, false, false, false, false, false, false, false, false, false, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
var arrayMetadata    = [ [ "1", "GSM1390744_91888.CEL.gz", "1", "10/18/05 11:13:31" ], [ "2", "GSM1390769_91914.CEL.gz", "2", "10/20/05 13:19:47" ], [ "3", "GSM1390770_91915.CEL.gz", "3", "10/21/05 10:22:28" ], [ "4", "GSM1390777_91922.CEL.gz", "4", "10/21/05 14:03:22" ], [ "5", "GSM1390784_91929.CEL.gz", "5", "10/25/05 10:36:17" ], [ "6", "GSM1390788_91933.CEL.gz", "6", "10/25/05 11:06:13" ], [ "7", "GSM1390804_91994.CEL.gz", "7", "10/25/05 14:51:52" ], [ "8", "GSM1390809_91999.CEL.gz", "8", "10/25/05 16:21:35" ], [ "9", "GSM1390811_92001.CEL.gz", "9", "10/25/05 17:37:42" ], [ "10", "GSM1390813_92003.CEL.gz", "10", "10/25/05 16:55:55" ], [ "11", "GSM1390816_92006.CEL.gz", "11", "10/26/05 10:45:53" ], [ "12", "GSM1390827_92018.CEL.gz", "12", "10/26/05 12:05:41" ], [ "13", "GSM1390828_92019.CEL.gz", "13", "10/26/05 12:13:38" ], [ "14", "GSM1390851_92042.CEL.gz", "14", "10/27/05 12:24:51" ], [ "15", "GSM1390855_92046.CEL.gz", "15", "10/27/05 12:56:45" ], [ "16", "GSM1390864_92055.CEL.gz", "16", "10/27/05 14:02:44" ], [ "17", "GSM1390888_92088.CEL.gz", "17", "10/28/05 16:16:53" ], [ "18", "GSM1390889_92089.CEL.gz", "18", "10/28/05 15:49:42" ], [ "19", "GSM1390890_92090.CEL.gz", "19", "11/01/05 16:52:21" ], [ "20", "GSM1390914_92114.CEL.gz", "20", "11/01/05 17:20:08" ], [ "21", "GSM1390917_92118.CEL.gz", "21", "11/01/05 17:18:38" ], [ "22", "GSM1390922_92123.CEL.gz", "22", "10/28/05 10:19:45" ], [ "23", "GSM1390930_92131.CEL.gz", "23", "11/01/05 16:06:58" ], [ "24", "GSM1390953_92155.CEL.gz", "24", "10/28/05 11:59:12" ], [ "25", "GSM1390964_92168.CEL.gz", "25", "11/02/05 10:50:41" ], [ "26", "GSM1390968_92175.CEL.gz", "26", "11/02/05 15:17:31" ], [ "27", "GSM1390973_92180.CEL.gz", "27", "11/02/05 12:06:22" ], [ "28", "GSM1390993_92201.CEL.gz", "28", "11/02/05 14:54:47" ], [ "29", "GSM1391007_92219.CEL.gz", "29", "11/03/05 09:05:15" ], [ "30", "GSM1391025_92239.CEL.gz", "30", "11/03/05 11:41:42" ], [ "31", "GSM1391041_92256.CEL.gz", "31", "11/03/05 14:10:20" ], [ "32", "GSM1391048_92263.CEL.gz", "32", "11/03/05 15:02:34" ], [ "33", "GSM1391049_92264.CEL.gz", "33", "11/03/05 15:06:32" ], [ "34", "GSM1391068_92283.CEL.gz", "34", "11/04/05 09:03:00" ], [ "35", "GSM1391082_92298.CEL.gz", "35", "11/04/05 10:54:38" ], [ "36", "GSM1391087_92303.CEL.gz", "36", "11/04/05 11:31:56" ], [ "37", "GSM1391093_92309.CEL.gz", "37", "11/04/05 12:16:47" ], [ "38", "GSM1391155_92386.CEL.gz", "38", "11/08/05 13:59:59" ], [ "39", "GSM1391170_92407.CEL.gz", "39", "11/09/05 09:00:34" ], [ "40", "GSM1391176_92413.CEL.gz", "40", "11/09/05 09:45:19" ], [ "41", "GSM1391212_92455.CEL.gz", "41", "11/09/05 15:02:11" ], [ "42", "GSM1391213_92456.CEL.gz", "42", "11/09/05 15:09:29" ], [ "43", "GSM1391214_92457.CEL.gz", "43", "11/09/05 15:16:44" ], [ "44", "GSM1391215_92458.CEL.gz", "44", "11/09/05 15:24:14" ], [ "45", "GSM1391245_92489.CEL.gz", "45", "11/10/05 11:38:42" ], [ "46", "GSM1391248_92492.CEL.gz", "46", "11/10/05 12:00:54" ], [ "47", "GSM1391254_92498.CEL.gz", "47", "11/10/05 12:54:59" ], [ "48", "GSM1391258_92504.CEL.gz", "48", "11/10/05 13:34:07" ], [ "49", "GSM1391260_92506.CEL.gz", "49", "11/10/05 13:48:55" ], [ "50", "GSM1391270_92516.CEL.gz", "50", "11/10/05 15:00:45" ], [ "51", "GSM1391273_92519.CEL.gz", "51", "11/10/05 15:23:06" ], [ "52", "GSM1391279_92525.CEL.gz", "52", "11/10/05 15:21:45" ], [ "53", "GSM1391287_92533.CEL.gz", "53", "11/11/05 09:28:37" ], [ "54", "GSM1391309_92555.CEL.gz", "54", "11/11/05 12:20:41" ], [ "55", "GSM1391313_92560.CEL.gz", "55", "11/11/05 12:45:45" ], [ "56", "GSM1391318_92565.CEL.gz", "56", "11/11/05 13:22:41" ], [ "57", "GSM1391320_92567.CEL.gz", "57", "11/11/05 13:37:19" ], [ "58", "GSM1391328_92576.CEL.gz", "58", "11/11/05 14:42:38" ], [ "59", "GSM1391332_92580.CEL.gz", "59", "11/11/05 15:12:13" ], [ "60", "GSM1391334_92585.CEL.gz", "60", "11/11/05 14:50:57" ], [ "61", "GSM1391340_92594.CEL.gz", "61", "11/15/05 09:11:45" ], [ "62", "GSM1391373_92634.CEL.gz", "62", "11/15/05 14:15:06" ], [ "63", "GSM1391381_92642.CEL.gz", "63", "11/15/05 15:18:29" ], [ "64", "GSM1391386_92651.CEL.gz", "64", "11/16/05 09:03:57" ], [ "65", "GSM1391411_92684.CEL.gz", "65", "11/16/05 13:31:06" ], [ "66", "GSM1391418_92693.CEL.gz", "66", "11/16/05 13:35:46" ], [ "67", "GSM1391428_92705.CEL.gz", "67", "11/16/05 15:00:33" ], [ "68", "GSM1391432_92709.CEL.gz", "68", "11/16/05 15:29:51" ], [ "69", "GSM1391446_92723.CEL.gz", "69", "11/17/05 10:36:38" ], [ "70", "GSM1391447_92724.CEL.gz", "70", "11/17/05 10:44:06" ], [ "71", "GSM1391451_92728.CEL.gz", "71", "11/17/05 11:29:03" ], [ "72", "GSM1391462_92740.CEL.gz", "72", "11/17/05 13:36:43" ], [ "73", "GSM1391463_92741.CEL.gz", "73", "11/17/05 13:44:09" ], [ "74", "GSM1391477_92755.CEL.gz", "74", "11/17/05 14:07:57" ], [ "75", "GSM1391478_92756.CEL.gz", "75", "11/17/05 14:15:33" ], [ "76", "GSM1391486_92764.CEL.gz", "76", "11/17/05 15:40:08" ], [ "77", "GSM1391493_92786.CEL.gz", "77", "11/17/05 15:16:12" ], [ "78", "GSM1391507_92800.CEL.gz", "78", "11/18/05 10:15:16" ], [ "79", "GSM1391515_92809.CEL.gz", "79", "11/18/05 11:12:04" ], [ "80", "GSM1391517_92811.CEL.gz", "80", "11/18/05 11:27:05" ], [ "81", "GSM1391534_92832.CEL.gz", "81", "11/18/05 13:58:20" ], [ "82", "GSM1391547_92845.CEL.gz", "82", "11/18/05 15:07:30" ], [ "83", "GSM1391550_92848.CEL.gz", "83", "11/18/05 15:30:01" ], [ "84", "GSM1391551_92849.CEL.gz", "84", "11/18/05 15:45:06" ], [ "85", "GSM1391559_92861.CEL.gz", "85", "11/22/05 16:15:31" ], [ "86", "GSM1391567_92871.CEL.gz", "86", "11/22/05 12:07:47" ], [ "87", "GSM1391569_92876.CEL.gz", "87", "11/22/05 12:22:45" ], [ "88", "GSM1391575_92883.CEL.gz", "88", "11/22/05 12:57:25" ], [ "89", "GSM1391589_92899.CEL.gz", "89", "11/22/05 14:55:11" ], [ "90", "GSM1391598_92910.CEL.gz", "90", "11/23/05 09:22:31" ], [ "91", "GSM1391686_93062.CEL.gz", "91", "11/30/05 15:27:53" ], [ "92", "GSM1391711_93898.CEL.gz", "92", "12/21/05 13:07:43" ], [ "93", "GSM1391712_93899.CEL.gz", "93", "12/22/05 10:27:50" ], [ "94", "GSM1391713_93900.CEL.gz", "94", "01/04/06 11:34:54" ], [ "95", "GSM1391719_93907.CEL.gz", "95", "12/21/05 13:29:56" ], [ "96", "GSM1391720_93908.CEL.gz", "96", "12/22/05 10:49:19" ], [ "97", "GSM1391721_93909.CEL.gz", "97", "01/04/06 11:57:07" ], [ "98", "GSM1391735_93924.CEL.gz", "98", "12/21/05 13:08:33" ], [ "99", "GSM1391736_93925.CEL.gz", "99", "12/22/05 11:33:16" ], [ "100", "GSM1391737_93926.CEL.gz", "100", "01/04/06 11:43:33" ], [ "101", "GSM1391756_93981.CEL.gz", "101", "12/22/05 11:15:30" ], [ "102", "GSM1391757_93982.CEL.gz", "102", "01/04/06 16:13:39" ], [ "103", "GSM1391758_93983.CEL.gz", "103", "01/06/06 15:29:26" ], [ "104", "GSM1391786_96990.CEL.gz", "104", "04/06/06 12:48:59" ], [ "105", "GSM1391788_96992.CEL.gz", "105", "04/06/06 14:45:55" ], [ "106", "GSM1391789_96993.CEL.gz", "106", "04/07/06 13:50:16" ], [ "107", "GSM1391798_97002.CEL.gz", "107", "04/06/06 13:11:43" ], [ "108", "GSM1391806_97010.CEL.gz", "108", "04/11/06 15:21:55" ], [ "109", "GSM1391809_97013.CEL.gz", "109", "04/06/06 14:38:26" ], [ "110", "GSM1391823_97027.CEL.gz", "110", "04/14/06 15:56:04" ], [ "111", "GSM1391840_97452.CEL.gz", "111", "04/20/06 08:37:29" ], [ "112", "GSM1391844_97456.CEL.gz", "112", "04/20/06 10:24:29" ], [ "113", "GSM1391851_97463.CEL.gz", "113", "04/20/06 11:16:42" ], [ "114", "GSM1391854_97466.CEL.gz", "114", "04/20/06 10:24:54" ], [ "115", "GSM1391855_97467.CEL.gz", "115", "04/20/06 10:32:28" ], [ "116", "GSM1391864_97476.CEL.gz", "116", "04/21/06 11:13:22" ], [ "117", "GSM1391870_97482.CEL.gz", "117", "04/21/06 10:58:08" ], [ "118", "GSM1391871_97483.CEL.gz", "118", "04/21/06 11:05:36" ], [ "119", "GSM1391882_97495.CEL.gz", "119", "04/21/06 13:18:22" ], [ "120", "GSM1391887_97500.CEL.gz", "120", "04/21/06 12:56:16" ], [ "121", "GSM1391896_97509.CEL.gz", "121", "04/21/06 14:42:43" ], [ "122", "GSM1391938_97816.CEL.gz", "122", "05/02/06 08:50:16" ], [ "123", "GSM1391954_97832.CEL.gz", "123", "05/02/06 10:33:43" ], [ "124", "GSM1391959_97837.CEL.gz", "124", "05/02/06 11:10:46" ], [ "125", "GSM1392001_97883.CEL.gz", "125", "05/03/06 11:08:08" ], [ "126", "GSM1392004_97886.CEL.gz", "126", "05/03/06 10:31:15" ], [ "127", "GSM1392005_97888.CEL.gz", "127", "05/03/06 10:46:22" ], [ "128", "GSM1392023_97906.CEL.gz", "128", "05/03/06 15:09:36" ], [ "129", "GSM1392025_97908.CEL.gz", "129", "05/04/06 08:38:14" ], [ "130", "GSM1392027_97910.CEL.gz", "130", "05/04/06 08:53:15" ], [ "131", "GSM1392034_97917.CEL.gz", "131", "05/04/06 08:44:41" ], [ "132", "GSM1392037_97921.CEL.gz", "132", "05/04/06 09:14:41" ], [ "133", "GSM1392039_97923.CEL.gz", "133", "05/04/06 10:15:51" ], [ "134", "GSM1392048_97933.CEL.gz", "134", "05/04/06 10:31:16" ], [ "135", "GSM1392053_97938.CEL.gz", "135", "05/04/06 11:09:13" ], [ "136", "GSM1392058_97943.CEL.gz", "136", "05/04/06 13:03:11" ], [ "137", "GSM1392072_97969.CEL.gz", "137", "05/04/06 14:41:17" ], [ "138", "GSM1392074_97971.CEL.gz", "138", "05/04/06 14:56:20" ], [ "139", "GSM1392082_97980.CEL.gz", "139", "05/04/06 15:04:23" ], [ "140", "GSM1392084_97982.CEL.gz", "140", "05/05/06 10:48:22" ], [ "141", "GSM1392085_97983.CEL.gz", "141", "05/05/06 10:55:52" ], [ "142", "GSM1392095_97993.CEL.gz", "142", "05/05/06 11:10:42" ], [ "143", "GSM1392136_98036.CEL.gz", "143", "05/05/06 13:41:41" ], [ "144", "GSM1392141_98041.CEL.gz", "144", "05/09/06 10:49:34" ], [ "145", "GSM1392143_98043.CEL.gz", "145", "05/10/06 09:24:39" ], [ "146", "GSM1392144_98054.CEL.gz", "146", "05/09/06 09:05:48" ], [ "147", "GSM1392145_98061.CEL.gz", "147", "05/10/06 10:14:23" ] ];
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
