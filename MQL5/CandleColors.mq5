//+------------------------------------------------------------------+
//|                                                 CandleColors.mq5 |
//|                                                   Canal Devzando |
//|                           Parceria    http://www.itanlise.com.br |
//+------------------------------------------------------------------+

#property indicator_chart_window
#property indicator_buffers 5
#property indicator_plots 1
#property indicator_type1 DRAW_COLOR_CANDLES
#property indicator_label1 "Open;High;Low;Close"


//Arrays para armazenar dados para o indicador
double openbuffer[];
double highbuffer[];
double lowbuffer[];
double closebuffer[];
double colorsbuffer[];


//Indique o numero de cores e o valor de cada cor dentro do colchetes
color Cores[5] = {CLR_NONE, Navy, Tomato, clrDarkMagenta,Green};

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//Indica os arrays que contem os valores do indicador

   SetIndexBuffer(0,openbuffer,INDICATOR_DATA);
   SetIndexBuffer(1,highbuffer,INDICATOR_DATA);
   SetIndexBuffer(2,lowbuffer,INDICATOR_DATA);
   SetIndexBuffer(3,closebuffer,INDICATOR_DATA);
   SetIndexBuffer(4,colorsbuffer,INDICATOR_COLOR_INDEX);



//Especifica a quantidade de cores (a mesma do array "Cores")
   PlotIndexSetInteger(0,PLOT_COLOR_INDEXES,5);

//Cria os valores de cores para o indicador
//De acordo com a sequencia do array "Cores"
//O loop começa com 1 pois 0 será nulo ou a cor branca
//E percorre a quantidade de cores do array "Cores"

   for(int i=1; i<5; i++)
     {
      PlotIndexSetInteger(0,PLOT_LINE_COLOR,i,Cores[i]);
     }

   IndicatorSetInteger(INDICATOR_DIGITS,_Digits);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//Confere se não está sem valores
   if(rates_total < 1)
      return (rates_total);
   else


      for(int i=1; i<rates_total; i++)
        {

         //Inicializa os valores dos candles para os dados do indicador
         openbuffer[i] = open[i];
         highbuffer[i] = high[i];
         lowbuffer[i] = low[i];
         closebuffer[i] = close[i];

         //Aqui você implementa sua logica
         if(close[i] < close[i-1]) //se o fechamento atual for menor que o fechamento anterior
           {
            colorsbuffer[i] = 2; //aplica a cor "Tomato" especificada no array "Cores"
           }
         else // se o fechamento atual não for menor que o fechamento anterior
            colorsbuffer[i] = 1; //aplica a cor "Navy" especificada no array "Cores"
        }

   return(rates_total);
  }
//+------------------------------------------------------------------+
