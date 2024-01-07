import 'package:flutter/material.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
 Widget build(BuildContext context){
  return MaterialApp(home: Home(),);
 }
}

class Home extends StatefulWidget{
  @override
HomeState createState() => HomeState();
}
class HomeState extends State<Home>{
  int scorePlayerOne = 0; //creation of score variables (scores for each player)
  int scorePlayerTwo = 0;
  int numCol = 3;
  List <String> displayVar = ['','','','','','','','','']; //List to store and display each symbol
   //on the score board(X & O)
  int boxesFull = 0; //keeps track of the number of boxes that are filled on the grid
  bool turn1 = true; //true if it is player one's turn (used to find whether to display X or O)
  bool fullGrid = false; //checks if grid is full to check if the players have tied
  @override
  Widget build(BuildContext context){
    //creation of scoreboard
    return Scaffold(appBar: AppBar(title: const Text('Tic Tac Toe Game', style:TextStyle(color:Color.fromARGB(255, 238, 148, 238))), backgroundColor:const Color.fromARGB(213, 95, 70, 255),),
    backgroundColor: const Color.fromARGB(255, 1, 12, 37),
    body: Column(children: [Expanded(child: Row(
      mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[Padding(
        padding: const EdgeInsets.all(30.0), child: Column(children:[
        const Text('Player 1 (X) score',
         style: TextStyle(color: Color.fromARGB(255, 7, 255, 255),fontSize:14)),
        Text(scorePlayerOne.toString(),style: const TextStyle( color: Color.fromARGB(255, 255, 7, 255)))]),
      ),Padding(
        padding: const EdgeInsets.all(30.0), child: Column(children:[
        const Text('Player 2 (O) score',
         style: TextStyle(color: Color.fromARGB(255, 7, 255, 255), fontSize:14)),
        Text(scorePlayerTwo.toString(),style: const TextStyle( color: Color.fromARGB(255, 255, 7, 255)))]),
    )]),
      
    ),//creation of tic tac toe grid/board
     Expanded(flex: 4,child:GridView.builder(
        itemCount:9,gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),itemBuilder: (BuildContext context, int index){
        return GestureDetector(onTap:(){tapped(index);},child: Container(
              decoration: BoxDecoration(color: const Color.fromARGB(255, 22, 1, 83),border:Border.all(width:6.0, color:const Color.fromARGB(255, 15, 231, 155)))
          ,child: Center(child: Text(displayVar[index],style: const TextStyle(color:Color.fromARGB(255, 210, 159, 209), fontSize: 24),))));
      },
    )), //Reset button for resetting the scoreboard
    Expanded(child:Row( 
      mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
        TextButton(style:ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 250, 93, 247)),foregroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 215, 204, 234))) ,onPressed:resetScoreBoard ,child:const Text('Reset Score Board', style:TextStyle(fontSize:20))
    )],
      ),)],));
  }
  //Method to check if either play has won (calls to display the winner) or calls the method to display a tie
  void winner(){
    for(int i = 0 ; i < 7; i+=3){
    if(displayVar[i] != '' && displayVar[i]==displayVar[i+1]&& displayVar[i+1]==displayVar[i+2]){
      winDisplay(displayVar[i]);
    }
    }
    for(int i = 0 ; i < 3; i++){
    if(displayVar[i] != '' && displayVar[i]==displayVar[i+3]&& displayVar[i+3]==displayVar[i+6]){
      winDisplay(displayVar[i]);
    }
    }
    if(displayVar[0]!=''&&displayVar[0]==displayVar[4]&&displayVar[4]==displayVar[8]){
      winDisplay(displayVar[0]);
    }
    if(displayVar[2]!=''&&displayVar[2]==displayVar[4]&&displayVar[4]==displayVar[6]){
      winDisplay(displayVar[2]);
    }
    else if(fullGrid){
      tie();
    }

  }
  //Displays the winner of the game using an AlertDialog 
  void winDisplay(String s){
    String player = "";
    if(s == 'X'){
      player = '1';
    }
    else{
      player = '2';
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: const Color.fromARGB(253, 4, 247, 162),
      builder:(BuildContext context){
        return AlertDialog(
          title:Text('Yay, you won Player ' + player + '!'),
         
          actions:<Widget>[
             TextButton(
              child:const  Text('Play again'),
              onPressed: () => {resetBoard, Navigator.pop(context), 
              if(s=='O'){
              scorePlayerTwo++
              }, if(s=='X'){scorePlayerOne++}
             }
            ),
          ]


        );
      }

    );
    resetBoard();
  
  }
  //Displays if the game is tied (neither player has won) in an AlertDialog
  void tie(){
    showDialog(context: context, barrierDismissible: false, barrierColor: const Color.fromARGB(255, 4, 239, 247), builder: (BuildContext context){
    return AlertDialog(
      title:const Text('Tied Game'),
      actions: <Widget>[
            TextButton(
              child: const Text('Try again'),
              onPressed: () => {resetBoard, Navigator.pop(context),
             }
            ),
          ],


    );
   });
   resetBoard();
  }
  //Method is called when a button is tapped (and checks whether to display X or O depending on which 
  //player's turn it is)
void tapped(int i){
  setState(() {
    if(turn1==true&&displayVar[i] == ''){
      displayVar[i] ='O';
      turn1 = false;
      boxesFull++;
    }
    if(turn1==false&&displayVar[i] == ''){
      displayVar[i] ='X';
      turn1 = true;
      boxesFull++;
    }
    if (boxesFull==9){
      fullGrid = true;
    }
    winner(); //checks if either player has won

    
  });

}
//Method to reset the tic tac toe grid/board when a game has been completed (either through a win or tie)
void resetBoard(){
  setState(() {
    boxesFull = 0;
    for(int i = 0; i < 9; i++){
       displayVar[i] = '';}
   
     fullGrid = false;

  });
}

//Method to reset the scoreboard (is called when the 'Reset Scoreboard' button is clicked)
void resetScoreBoard(){
  setState(() {
     boxesFull = 0;
     displayVar = ['','','','','','','','',''];
     fullGrid = false;
     scorePlayerOne = 0;
     scorePlayerTwo = 0;
  });
}

}
