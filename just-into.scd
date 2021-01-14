// just meditations (20210111)
// justice to nation (in a several harmonic spaces)
// just-into (a several harmonic spaces)

//creacion de campos armonicos relacionados proporcionalmente entre y dentro de si por x/y razones de distancia y n desviaciones en Hz.

//campo 1 alrededor de 100Hz
(
~relaciones1=[1/1,3/2,2/3,9/8,8/9,16/9,9/16].asStream;
~ratios1=Array.fillND([4,4],{arg i;i=~relaciones1.choose});//choose or scramble

// ~fFunds1=100*~relaciones1*2.asStream;//para el diodo
~fFunds1=Array.fill(2,{arg i;i=~relaciones1*100});//para acorde de 7 notas
~grow1=Array.geom(3,100,[3,5]);
)

//test
x={SinOsc.ar(~fFunds1.choose*~ratios1.choose,0,0.1)}.play;
x.free;
y={SinOsc.ar(~fFunds1.choose*~ratios1.choose,0,Pulse.kr([5,3,2,7].choose,0.5,0.1))}.play;
y.free;

//campo 2 alrededor de 200+11Hz
(
~relaciones2=[1/1,4/3,3/4,5/3,3/5,11/16,5/8].asStream;
~ratios2=Array.fillND([4,4],{arg i;i=~relaciones2.choose});//choose or scramble
// ~fFunds2=211*~relaciones2;//otra opcion
~fFunds2D=Array.fill(2,{arg i;i=~relaciones2*211});
~grow2=Array.geom(3,211,[2,3]);
)
//campo 3 alrededor de 400Hz
(
~relaciones3=[1/1,1/2,2/1,3/2,2/3,4/3,3/4,27/28,5/4].asStream;
~ratios3=Array.fillND([4,4],{arg i;i=~relaciones3.choose});
// ~fFunds3=400*~relaciones3;//otra opcion
~fFunds3=Array.fill(2,{arg i;~relaciones3*400});
~grow3=Array.series(2,[400,401],[3,4]);
)
//campo 4 alrededor de 50hz
(
~relaciones4=[1/1,2/1,3/2,2/3,9/8,2,9/8].asStream;
~ratios4=Array.fillND([4,4],{arg i;i=~relaciones4.choose});
//~fFunds4=50*~relaciones4;
~fFunds4=Array.fill(2,{arg i;i=~relaciones4*50});
~grow4=Array.fib(4,50,3);
)

//Demand + Dseq o Drand
//secuenciar acordes de bloque
//para escucharlos x separado

//c a m p o  1
(
{
    var freq, trig, reset, seq;
	    trig = Dust.kr(Line.kr(0.1,0.4,30));
	//quiza hacerlo menos aleatorio, mas ponderado
	    seq = Drand(~fFunds1.scramble*~ratios1.choose*~grow1, inf);
    freq = Demand.kr(trig, 0, seq);
	2.collect{Pan2.ar(SinOsc.ar(freq + [0,0.7]).cubed * 0.05,Rand(-1.0,1.0))};
}.play;
)

//c a m p o  2
(
{
    var freq, trig, reset, seq;
	    trig = Dust.kr(Line.kr(0.1,0.4,30));
	//quiza hacerlo menos aleatorio, mas ponderado
	    seq = Drand(~fFunds2D.scramble*~ratios2.scramble*~grow2, inf);
    freq = Demand.kr(trig, 0, seq);
	2.collect{Pan2.ar(SinOsc.ar(freq + [0,0.7]).cubed * 0.05,Rand(-1,1))};
}.play;
)

//c a m p o  3
(
{
    var freq, trig, reset, seq;
	    trig = Dust.kr(Line.kr(0.1,0.4,30));
	//quiza hacerlo menos aleatorio, mas ponderado
	    seq = Drand(~fFunds3.scramble*~ratios3.choose*~grow3, inf);
    freq = Demand.kr(trig, 0, seq);
	    2.collect{SinOsc.ar(freq + [0,0.7]).cubed * 0.05!2};
}.play;
)

// c a m p o   4
//el campo 4 es mi favorito
(
{
    var freq, trig, reset, seq;
	    trig = Dust.kr(Line.kr(0.1,0.4,30));
	//quiza hacerlo menos aleatorio, mas ponderado
	    seq = Drand(~fFunds4.scramble*~ratios4.choose*~grow4, inf);
    freq = Demand.kr(trig, 0, seq);
	2.collect{Pan2.ar(SinOsc.ar(freq + [0,0.7]).cubed * 0.05,Rand(-1.0,1.0))};
}.play;
)

s.record;
s.stopRecording;
s.meter;
s.makeWindow;

//m i x e d   s p a c e s

//mixed space 1
//secuencia de acordes justos insospechados
//provenientes de 4 distintos campos armonicos

(
{
    var freq, trig, reset, seq,env;
	    trig = Dust.kr(Line.kr(0.1,0.4,30));
	//quiza hacerlo menos aleatorio, mas ponderado
	seq = Drand([Dseq(~fFunds1.scramble*~ratios1.scramble, 1), Dseq([~fFunds2D.choose*~ratios2.choose/4],1),Dseq([~fFunds3.choose*~ratios3.choose],1),Dseq(~fFunds4.choose*~ratios4.choose)], inf);
    freq = Demand.kr(trig, 0, seq);
	env=EnvGen.ar(Env.asr(rrand(0.1,3),rrand(0.3,0.5),rrand(3,5)),doneAction:2);
	2.collect{HPF.ar(SinOsc.ar(freq + [0,0.7]).cubed * 0.05*env,10)!2};//revisar detune
}.play;
)

s.record;
s.stopRecording;

//mixed space 2
//sin envolventes, con pop digital

(
{
    var freq, trig, reset, seq;
	trig = Impulse.kr(0.125);
	//quiza hacerlo menos aleatorio, mas ponderado
	seq = Drand([Dseq(~fFunds1.choose*~ratios1.choose, 2), Dseq([~fFunds2D.choose*~ratios2.choose/2],2),Dseq([~fFunds3.choose*~ratios3.choose],2),Dseq(~fFunds4.choose*~ratios4.choose)], inf);
    freq = Demand.kr(trig, 0, seq);
	    2.collect{SinOsc.ar(freq + [0,0.7]).cubed * 0.05};
}.play;
)

//mixed space 3
//sobreagudo, glitch-sine space

(
{
    var freq, trig, reset, seq,env;
	trig = Impulse.kr(0.5);
	//quiza hacerlo menos aleatorio, mas ponderado
	seq = Drand([Dseq(~fFunds1.choose/4*~ratios1.choose*~grow1, 2), Dseq([~fFunds2D.choose*~ratios2.choose/4*~grow2],2),Dseq([~fFunds3.choose/4*~ratios3.choose],2)*~grow3], inf);
	env=EnvGen.ar(Env.asr(rrand(0.01,5),rrand(0.2,0.5),rrand(3,7)),doneAction:2);
    freq = Demand.kr(trig, 0, seq);
	    2.collect{SinOsc.ar(freq + [0,0.7]) * 0.025*env!2};
}.play;
)

//detalles en otras timbricas

//el birimbao

(
~kplus1={LPF.ar(Pluck.ar(WhiteNoise.ar([0.4,0.2]), Impulse.kr([[5,3],[4,7]]), ~fFunds1.choose.reciprocal, ~fFunds3.choose.reciprocal, 10,coef:Line.kr(0.85,0.1,10),mul:Line.kr(0.3,0,25)),Line.kr(400,20000,12))!2}
)
~kplus1.play;

//otros recursos
//para lanzar listas

(
t = Task({
    50.do({ arg i;
        i.squared.postln;
        0.5.wait;
    });
});
)

t.start;
t.pause;
t.resume;
t.reset;
t.stop;

//desgranado 1 - arpegiador de acordes
//arp 1.1

(
~relacionesArp=[3/2,2/3,9/8,8/9,16/9,9/16].asStream;
~ratioArp=Array.fillND([5],{arg i;i=~relacionesArp.choose});

x={
    var freq, trig, reset, seq;
	trig = Impulse.kr(0.125);// o Line.kr(25,1,5)
	//quiza hacerlo menos aleatorio, mas ponderado
	seq = Dseq(~fFunds2D.choose*4*~ratioArp.scramble, inf);
	//scramble para acordes,choose para nota ind
    freq = Demand.kr(trig, 0, seq);
	    4.collect{SinOsc.ar(freq + [0,0.7],0,0.4)* 0.05!2};
}.play;

//arp1.2

y={
    var freq, trig, reset, seq;
	trig = Impulse.kr(0.5);
	//quiza hacerlo menos aleatorio, mas ponderado
	    seq = Dseq(~fFunds2D.scramble*~ratioArp.scramble, inf);
	//scramble para acordes, choose para nota ind
    freq = Demand.kr(trig, 0, seq);
	    2.collect{SinOsc.ar(freq + [0,0.7],0,0.3) * 0.05!2};
}.play;

//arp1.3

z={
    var freq, trig, reset, seq;
	trig = Impulse.kr(0.75);
	//quiza hacerlo menos aleatorio, mas ponderado
	    seq = Dseq(~fFunds3.scramble*~ratioArp.scramble, inf);
	//scramble para acordes, choose para nota ind
    freq = Demand.kr(trig, 0, seq);
	    2.collect{SinOsc.ar(freq + [0,0.7],0,0,3)* 0.05!2};
}.play;
)

//desgranado 2

//arp 2.1
//note per note rand-ritm arp

(
~relacionesArp=[3/2,2/3,9/8,8/9,16/9,9/16].asStream;
~ratioArp=Array.fillND([5],{arg i;i=~relacionesArp.choose});

~x={
	|t1=15,t2=15,rel=2|
	var freq, trig, reset, seq,env;
	trig = Impulse.kr(EnvGen.ar(Env([10,Dust.kr(0.1),25,1],[15,30,15,15]),doneAction:2));//Dust.kr(4);// o Line.kr(25,1,5)
	//quiza hacerlo menos aleatorio, mas ponderado
	seq = Dseq(~fFunds4.choose*~ratios4.choose, 9);
	//scramble para acordes,choose para nota ind o al reves?
	env=EnvGen.ar(Env([1,0.5],[t1,t2,rel]),doneAction:2);
    freq = Demand.kr(trig, 0, seq);
	    2.collect{SinOsc.ar(freq + [0,0.7]).cubed* 0.1*env!2};
};
)
~x.play;

//arp 2.2
//ritmo constante

(
~relacionesArp2=[1/1,2/1,3/2,2/3,9/8,2,9/8,15/8].scramble.asStream;
~ratioArp2=Array.fillND([5],{arg i;i=~relacionesArp2.choose});

~y={
	|t1=15,t2=15,rel=4|
	var freq, trig, reset, seq,env;
	trig = Impulse.kr(8);//Dust.kr(4);// o Line.kr(25,1,5)
	//quiza hacerlo menos aleatorio, mas ponderado
	seq = Dseq(~fFunds4.choose*~ratios4.choose, 9);
	//scramble para acordes,choose para nota ind o al reves?
	env=EnvGen.ar(Env([1,0.5],[t1,t2,rel]),doneAction:2);
    freq = Demand.kr(trig, 0, seq);
	    2.collect{SinOsc.ar(freq + [0,0.7]).cubed* 0.1*env!2};
};
)
~y.play;

//arp2.3
//secuencia de acordes de octavas quintas y segundas mayores

(
~z={
	|t1=60,t2=60,rel=8|
	var freq, trig, reset, seq,env;
	trig = Dust.kr(1);//Dust.kr(4);// o Line.kr(25,1,5)
	//quiza hacerlo menos aleatorio, mas ponderado
	seq = Dseq(~fFunds4.scramble*~ratios4, 9);
	//scramble para acordes,choose para nota ind o al reves?
	env=EnvGen.ar(Env([1,0.5],[t1,t2,rel]),doneAction:2);
    freq = Demand.kr(trig, 0, seq);
	    2.collect{SinOsc.ar(freq + [0,0.7]).cubed* 0.045*env!2};
};
)

~z.play;

//desgranado 3

//arp 3.1
//kids - stranger things chords

(
~a={
	|t1=40,t2=40,rel=8|
	var freq, trig, reset, seq,env;
	trig =Impulse.kr(Line.kr(10,0.75,10));
	seq = Dseq(~fFunds4.choose*~ratios4, inf);
	//scramble para acordes,choose para nota ind o al reves?
	env=EnvGen.ar(Env([1,0.5],[t1,t2,rel]),doneAction:2);
    freq = Demand.kr(trig, 0, seq);
	    2.collect{SinOsc.ar(freq + [0,0.7]).cubed* 0.05*env!2};
};
)
~a.play;

(
~b={
	|t1=30,t2=30,rel=8|
	var freq, trig, reset, seq,env;
	trig =Impulse.kr(4);//Line.kr(23,0.75,5
	seq = Dseq(~fFunds4.scramble*2*~ratios4.scramble, inf);
	//scramble para acordes,choose para nota ind o al reves?
	env=EnvGen.ar(Env([1,0.5],[t1,t2,rel]),doneAction:2);
    freq = Demand.kr(trig, 0, seq);
	    2.collect{SinOsc.ar(freq + [0,0.7]).cubed* 0.05*env};
};
)
~b.play;

//daniel perez arechiga
//Enero 2021
