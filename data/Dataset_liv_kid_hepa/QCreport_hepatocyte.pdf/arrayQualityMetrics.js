// (C) Wolfgang Huber 2010-2011

// Script parameters - these are set up by R in the function 'writeReport' when copying the 
//   template for this script from arrayQualityMetrics/inst/scripts into the report.

var highlightInitial = [ false, true, false, true, true, false, false, false, false, false, false, false, false, false, false, false, false, true, false, false, false, false, false, false, false, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false ];
var arrayMetadata    = [ [ "1", "GSM1389835_93010.CEL.gz", "1", "11/30/05 09:38:46" ], [ "2", "GSM1389840_93015.CEL.gz", "2", "11/30/05 10:16:11" ], [ "3", "GSM1389854_93030.CEL.gz", "3", "12/01/05 10:14:05" ], [ "4", "GSM1389856_93032.CEL.gz", "4", "12/01/05 10:28:47" ], [ "5", "GSM1389860_93036.CEL.gz", "5", "12/01/05 11:16:28" ], [ "6", "GSM1389864_93067.CEL.gz", "6", "12/01/05 11:53:44" ], [ "7", "GSM1389867_93070.CEL.gz", "7", "12/01/05 12:16:06" ], [ "8", "GSM1389893_93096.CEL.gz", "8", "12/01/05 14:46:47" ], [ "9", "GSM1389894_93097.CEL.gz", "9", "12/01/05 14:54:20" ], [ "10", "GSM1389913_93116.CEL.gz", "10", "12/02/05 09:15:54" ], [ "11", "GSM1389917_93120.CEL.gz", "11", "12/02/05 10:42:33" ], [ "12", "GSM1389924_93127.CEL.gz", "12", "12/02/05 11:34:51" ], [ "13", "GSM1389929_93132.CEL.gz", "13", "12/02/05 12:19:38" ], [ "14", "GSM1389936_93139.CEL.gz", "14", "12/02/05 13:33:22" ], [ "15", "GSM1389937_93140.CEL.gz", "15", "12/02/05 13:40:35" ], [ "16", "GSM1389948_93174.CEL.gz", "16", "12/02/05 14:54:12" ], [ "17", "GSM1389958_93184.CEL.gz", "17", "12/02/05 14:56:56" ], [ "18", "GSM1389959_93185.CEL.gz", "18", "12/02/05 15:04:11" ], [ "19", "GSM1389961_93187.CEL.gz", "19", "12/02/05 15:19:09" ], [ "20", "GSM1389963_93189.CEL.gz", "20", "12/06/05 08:54:49" ], [ "21", "GSM1390001_93228.CEL.gz", "21", "12/06/05 13:23:25" ], [ "22", "GSM1390007_93234.CEL.gz", "22", "12/06/05 13:18:51" ], [ "23", "GSM1390013_93240.CEL.gz", "23", "12/06/05 15:17:09" ], [ "24", "GSM1390020_93247.CEL.gz", "24", "12/06/05 15:17:20" ], [ "25", "GSM1390025_93252.CEL.gz", "25", "12/07/05 16:17:08" ], [ "26", "GSM1390035_93278.CEL.gz", "26", "12/07/05 09:24:23" ], [ "27", "GSM1390039_93282.CEL.gz", "27", "12/07/05 11:13:53" ], [ "28", "GSM1390042_93285.CEL.gz", "28", "12/07/05 11:43:19" ], [ "29", "GSM1390044_93287.CEL.gz", "29", "12/07/05 12:12:14" ], [ "30", "GSM1390055_93299.CEL.gz", "30", "12/07/05 15:15:12" ], [ "31", "GSM1390060_93304.CEL.gz", "31", "12/07/05 12:57:32" ], [ "32", "GSM1390063_93307.CEL.gz", "32", "12/07/05 12:43:38" ], [ "33", "GSM1390064_93308.CEL.gz", "33", "12/07/05 12:50:50" ], [ "34", "GSM1390079_93323.CEL.gz", "34", "12/07/05 12:58:25" ], [ "35", "GSM1390082_93326.CEL.gz", "35", "12/07/05 13:20:04" ], [ "36", "GSM1390091_93335.CEL.gz", "36", "12/08/05 09:59:04" ], [ "37", "GSM1390092_93336.CEL.gz", "37", "12/08/05 10:06:19" ], [ "38", "GSM1390096_93340.CEL.gz", "38", "12/08/05 10:35:59" ], [ "39", "GSM1390125_93369.CEL.gz", "39", "12/08/05 12:56:01" ], [ "40", "GSM1390141_93385.CEL.gz", "40", "12/08/05 14:56:12" ], [ "41", "GSM1390145_93389.CEL.gz", "41", "12/12/05 08:54:37" ], [ "42", "GSM1390151_93395.CEL.gz", "42", "12/09/05 09:36:53" ], [ "43", "GSM1390152_93396.CEL.gz", "43", "12/09/05 09:44:11" ], [ "44", "GSM1390153_93397.CEL.gz", "44", "12/09/05 09:51:26" ], [ "45", "GSM1390181_93425.CEL.gz", "45", "12/09/05 13:01:55" ], [ "46", "GSM1390198_93442.CEL.gz", "46", "12/09/05 14:58:22" ], [ "47", "GSM1390203_93447.CEL.gz", "47", "12/12/05 10:09:45" ], [ "48", "GSM1390208_93452.CEL.gz", "48", "12/12/05 10:46:54" ], [ "49", "GSM1390229_93473.CEL.gz", "49", "12/13/05 11:53:23" ], [ "50", "GSM1390230_93474.CEL.gz", "50", "12/13/05 12:00:58" ], [ "51", "GSM1390234_93478.CEL.gz", "51", "12/13/05 13:38:54" ], [ "52", "GSM1390256_93500.CEL.gz", "52", "12/13/05 15:19:48" ], [ "53", "GSM1390263_93507.CEL.gz", "53", "12/13/05 15:10:51" ], [ "54", "GSM1390264_93508.CEL.gz", "54", "12/13/05 15:18:17" ], [ "55", "GSM1390265_93509.CEL.gz", "55", "12/13/05 15:26:36" ], [ "56", "GSM1390275_93519.CEL.gz", "56", "12/15/05 10:17:59" ], [ "57", "GSM1390277_93521.CEL.gz", "57", "12/15/05 15:16:02" ], [ "58", "GSM1390284_93528.CEL.gz", "58", "12/16/05 09:50:25" ], [ "59", "GSM1390296_93540.CEL.gz", "59", "12/16/05 11:20:49" ], [ "60", "GSM1390298_93542.CEL.gz", "60", "12/16/05 11:06:01" ], [ "61", "GSM1390305_93550.CEL.gz", "61", "12/16/05 13:03:56" ], [ "62", "GSM1390309_93554.CEL.gz", "62", "12/16/05 13:39:17" ], [ "63", "GSM1390325_93571.CEL.gz", "63", "12/13/05 10:35:37" ], [ "64", "GSM1390354_93604.CEL.gz", "64", "12/14/05 11:32:02" ], [ "65", "GSM1390356_93606.CEL.gz", "65", "12/14/05 11:17:10" ], [ "66", "GSM1390367_93617.CEL.gz", "66", "12/14/05 12:49:39" ], [ "67", "GSM1390370_93621.CEL.gz", "67", "12/14/05 13:34:03" ], [ "68", "GSM1390376_93627.CEL.gz", "68", "12/14/05 15:31:07" ], [ "69", "GSM1390379_93630.CEL.gz", "69", "12/14/05 15:08:40" ], [ "70", "GSM1390383_93634.CEL.gz", "70", "12/14/05 15:36:01" ], [ "71", "GSM1390384_93635.CEL.gz", "71", "12/14/05 15:28:31" ], [ "72", "GSM1390385_93636.CEL.gz", "72", "12/14/05 15:21:20" ], [ "73", "GSM1390398_93649.CEL.gz", "73", "12/15/05 09:34:29" ], [ "74", "GSM1390402_93653.CEL.gz", "74", "12/15/05 10:25:31" ], [ "75", "GSM1390421_93672.CEL.gz", "75", "12/15/05 12:46:35" ], [ "76", "GSM1390438_93689.CEL.gz", "76", "12/15/05 15:00:55" ], [ "77", "GSM1390443_93694.CEL.gz", "77", "12/15/05 15:23:13" ], [ "78", "GSM1390456_93710.CEL.gz", "78", "12/16/05 15:09:46" ], [ "79", "GSM1390462_93718.CEL.gz", "79", "12/16/05 15:32:21" ], [ "80", "GSM1390463_93719.CEL.gz", "80", "12/16/05 15:25:07" ], [ "81", "GSM1390467_93723.CEL.gz", "81", "12/19/05 09:46:57" ], [ "82", "GSM1390477_93733.CEL.gz", "82", "12/19/05 12:43:53" ], [ "83", "GSM1390488_93746.CEL.gz", "83", "12/19/05 11:07:16" ], [ "84", "GSM1390499_93757.CEL.gz", "84", "12/19/05 13:35:08" ], [ "85", "GSM1390501_93759.CEL.gz", "85", "12/19/05 13:20:25" ], [ "86", "GSM1390514_93772.CEL.gz", "86", "12/19/05 15:38:29" ], [ "87", "GSM1390527_93786.CEL.gz", "87", "12/20/05 09:33:11" ], [ "88", "GSM1390540_93806.CEL.gz", "88", "12/20/05 10:40:37" ], [ "89", "GSM1390543_93809.CEL.gz", "89", "12/20/05 11:02:43" ], [ "90", "GSM1390550_93818.CEL.gz", "90", "12/20/05 12:04:30" ], [ "91", "GSM1390562_93839.CEL.gz", "91", "12/21/05 10:11:00" ], [ "92", "GSM1390565_93843.CEL.gz", "92", "12/21/05 11:37:46" ], [ "93", "GSM1390569_93849.CEL.gz", "93", "12/20/05 15:30:07" ], [ "94", "GSM1390574_93856.CEL.gz", "94", "12/20/05 15:16:08" ], [ "95", "GSM1390583_93875.CEL.gz", "95", "12/21/05 08:56:39" ], [ "96", "GSM1390595_93887.CEL.gz", "96", "12/21/05 11:00:30" ], [ "97", "GSM1390604_93935.CEL.gz", "97", "12/21/05 15:17:08" ], [ "98", "GSM1390612_93943.CEL.gz", "98", "12/21/05 15:07:57" ], [ "99", "GSM1390647_95950.CEL.gz", "99", "02/24/06 08:34:23" ], [ "100", "GSM1390649_95952.CEL.gz", "100", "02/24/06 08:49:10" ], [ "101", "GSM1390652_95955.CEL.gz", "101", "02/28/06 08:46:09" ], [ "102", "GSM1390654_95957.CEL.gz", "102", "02/28/06 09:01:07" ], [ "103", "GSM1390656_95959.CEL.gz", "103", "02/24/06 09:18:42" ], [ "104", "GSM1390658_95961.CEL.gz", "104", "03/01/06 10:07:02" ], [ "105", "GSM1390660_95963.CEL.gz", "105", "03/01/06 09:53:14" ], [ "106", "GSM1390662_95965.CEL.gz", "106", "02/24/06 09:26:02" ], [ "107", "GSM1390666_95969.CEL.gz", "107", "02/28/06 09:31:16" ], [ "108", "GSM1390668_95971.CEL.gz", "108", "03/02/06 08:38:34" ], [ "109", "GSM1390670_95973.CEL.gz", "109", "02/24/06 08:49:55" ], [ "110", "GSM1390674_96013.CEL.gz", "110", "03/01/06 09:19:22" ], [ "111", "GSM1390678_96017.CEL.gz", "111", "03/03/06 08:41:38" ], [ "112", "GSM1390680_96019.CEL.gz", "112", "02/28/06 08:38:09" ], [ "113", "GSM1390687_98414.CEL.gz", "113", "05/31/06 09:41:38" ], [ "114", "GSM1390689_98418.CEL.gz", "114", "06/01/06 09:52:33" ], [ "115", "GSM1390692_98716.CEL.gz", "115", "06/27/06 10:42:39" ] ];
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
