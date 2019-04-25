<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ page import="mx.com.sba.services.impl.SBAServiceImpl,mx.com.sba.graph.beans.Graph,mx.com.sba.utils.Utils,com.ws.wstools.services.data.atomic.VIGetGraphResult,mx.com.sba.graph.beans.Polarity,java.util.List " %>
    
    <%
    String dataforGraph=null;
    String lsdataforGraph=null;
    String lshdModoCarga = request.getParameter("hdModoCarga");
    if (lshdModoCarga==null)
    lshdModoCarga = "INICIO"; //si es vacio, se inicializa con INICIO
    
    
     try{   
	   
	   if(lshdModoCarga.equals("Busqueda"))
{

VIGetGraphResult SBAGraphResult=null;

String lsUserName= request.getParameter("text_busqueda"); 
String lsSN= request.getParameter("search-option"); 
String lsNumNodes= request.getParameter("text_numnodes"); 
String lsNumLevels= request.getParameter("text_numlevels"); 
session.setAttribute( "Consulta",lsUserName);
session.setAttribute( "NumNodes",lsNumNodes);
session.setAttribute( "NumLevels",lsNumLevels);
session.setAttribute( "SN",lsSN);

SBAGraphResult=SBAServiceImpl.GetGraphByUserName(lsUserName,lsSN,lsNumNodes,lsNumLevels,"","pol");

Graph graph =SBAGraphResult.getUsrPolarity().getGraph();
 lsdataforGraph=Utils.beanToJson(graph);
 //dataforGraph= lsdataforGraph.replaceAll("[\\p{Cntrl}&&[^\r\n\t]]", "");
 //dataforGraph= lsdataforGraph.replace("\n", "");
 dataforGraph= lsdataforGraph;
// dataforGraph= lsdataforGraph.replace("[\\p{Cntrl}&&[^\\r\\n\t]]", "");
 System.out.println(dataforGraph);

}

    }catch(Throwable ex)
    {
      ex.printStackTrace();
    }  

    %>
    
 <script language="JavaScript" type="text/javascript" >
    
  function Busqueda()
{
var forma = document.frmServidor;
  var nombreBusqueda =   forma.text_busqueda.value;
  
   if ((nombreBusqueda=="")) 
   {
      alert("Introduce a valid user"); 
      forma.nombreBusqueda.focus();
      return false;
   }
   

  var lsModoCarga = "Busqueda";
  forma.hdModoCarga.value=lsModoCarga ;
  forma.target = "_self";
  forma.method = "post";
  //alert("Enviar");
  forma.action = "Graph_Polarity.jsp?hdModoCarga=" + lsModoCarga;
  forma.submit();                
 
}  
  </script>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>SB Admin</title>
  <!-- Bootstrap core CSS-->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom fonts for this template-->
  <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
  <!-- Page level plugin CSS-->
  <link href="vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
  <!-- Custom styles for this template-->
  <link href="css/sb-admin.css" rel="stylesheet">
</head>



<body class="fixed-nav sticky-footer bg-dark" id="page-top">

<jsp:include page="includes/Navigation.jsp" />

  <div class="content-wrapper">
    <div class="container-fluid">
      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
          <li class="breadcrumb-item">
          <a >SBA Analytics</a>
        </li>
        <li class="breadcrumb-item">
          <a >Polarity</a>
        </li>
        <li class="breadcrumb-item active">Graph Polarity</li>
      </ol>
      	<div  >
	<form class="form-inline" name="frmServidor">
 
   <label class="sr-only" for="inlineFormInputGroup">Username</label>
  <div class="input-group mb-2 mr-sm-2 mb-sm-0">
    <div class="input-group-addon">User:</div>
    <input name="text_busqueda" type="text" class="form-control" id="inlineFormInputGroup" placeholder="Username" value=<%=session.getAttribute( "Consulta")!=null?session.getAttribute( "Consulta"):""%>>
  </div>
  <div class="form-check mb-2 mr-sm-2 mb-sm-0">
   <div class="input-group-addon">SN:</div>
    <select class="custom-select mb-2 mr-sm-2 mb-sm-0" id="inlineFormCustomSelect" name="search-option">
    <option  <%=session.getAttribute( "SN")==null?"selected":""%>>Choose...</option>
    <option value="facebook" <%=session.getAttribute( "SN")=="facebook"?"selected":""%>>Facebook</option>
    <option value="twitter" <%=session.getAttribute( "SN")=="twitter"?"selected":""%>>Twitter</option>
  </select>
   </div>
   
     <div class="input-group mb-2 mr-sm-2 mb-sm-0">
    <div class="input-group-addon">#</div>
    <input name="text_numnodes" type="text" class="form-control" id="inlineFormInputGroup" placeholder="Nodes" value=<%=session.getAttribute( "NumNodes")!=null?session.getAttribute( "NumNodes"):""%>>
  </div>
       <div class="input-group mb-2 mr-sm-2 mb-sm-0">
    <div class="input-group-addon">#</div>
    <input name="text_numlevels" type="text" class="form-control" id="inlineFormInputGroup" placeholder="Levels" value=<%=session.getAttribute( "NumLevels")!=null?session.getAttribute( "NumLevels"):""%>>
  </div>
 <button type="submit" class="btn btn-primary" value="Search" onclick="javascript:Busqueda()">Get Graph</button>
 
 <input type="hidden" name="hdModoCarga" value=""/>   
</form>
	</div >
     </div>
     <% if(dataforGraph!=null) { %>
       <div class="content-wrapper">
  <div align='left' id="d3_selectable_force_directed_graph" style="width: 560px; height: 400px;">
    <svg />
    </div>
   </div>       
<% }%>
     
    </div>


 
 </div>

<jsp:include page="includes/foot.jsp" />

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
      <i class="fa fa-angle-up"></i>
    </a>
    <!-- Logout Modal-->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
          </div>
          <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
          <div class="modal-footer">
            <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
            <a class="btn btn-primary" href="login.html">Logout</a>
          </div>
        </div>
      </div>
    </div>
    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
    <!-- Page level plugin JavaScript-->
    <script src="vendor/chart.js/Chart.min.js"></script>
    <script src="vendor/datatables/jquery.dataTables.js"></script>
    <script src="vendor/datatables/dataTables.bootstrap4.js"></script>
    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin.min.js"></script>
    <!-- Custom scripts for this page-->
    <script src="js/sb-admin-datatables.min.js"></script>
    <script src="js/sb-admin-charts.min.js"></script>
  </div>
</body>
<link rel='stylesheet' href='css/d3v4-selectable-zoomable-force-directed-graph.css'>
<!--  <script src="https://d3js.org/d3.v4.js"></script>-->
 <script src="js/d3.js"></script>
<script src="js/d3v4-brush-lite.js"></script>
<script src="js/d3v4-selectable-force-directed-graph.js"></script>

<script>

 var lsgraph = <%="\'"+dataforGraph+"\'"%>;
  //console.log('lsgraph', lsgraph);
  //  if(lsgraph!=null){
   var graph =JSON.parse(lsgraph); 
    var svg = d3.select('#d3_selectable_force_directed_graph');
    console.log('graph', graph);
    createV4SelectableForceDirectedGraph(svg,graph );
    

//}


</script>

</html>

