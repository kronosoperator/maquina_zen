import 'quote.dart';

abstract final class Masters {
  static const baizhang = ZenMaster('Baizhang Huaihai', era: '720–814');
  static const bankei = ZenMaster('Bankei Yōtaku', era: '1622–1693');
  static const bodhidharma = ZenMaster('Bodhidharma');
  static const dogen = ZenMaster('Dōgen', era: '1200–1253');
  static const dongshanShouchu = ZenMaster('Dongshan Shouchu', era: '910–990');
  static const hakuin = ZenMaster('Hakuin Ekaku', era: '1686–1769');
  static const huangbo = ZenMaster('Huangbo Xiyun', era: '†850');
  static const huineng = ZenMaster('Huineng', era: '638–713');
  static const linji = ZenMaster('Linji Yixuan', era: '†866');
  static const mazu = ZenMaster('Mazu Daoyi', era: '709–788');
  static const nanquan = ZenMaster('Nanquan Puyuan', era: '748–835');
  static const pang = ZenMaster('Pang Yun', era: '740–808');
  static const qingyuan = ZenMaster('Qingyuan Weixin');
  static const ryokan = ZenMaster('Ryōkan', era: '1758–1831');
  static const sawaki = ZenMaster('Kōdō Sawaki', era: '1880–1965');
  static const sengcan = ZenMaster('Sengcan', era: '†606');
  static const shitou = ZenMaster('Shitou Xiqian', era: '700–790');
  static const suzuki = ZenMaster('Shunryū Suzuki', era: '1904–1971');
  static const wumen = ZenMaster('Wumen Huikai', era: '1183–1260');
  static const yongjia = ZenMaster('Yongjia Xuanjue', era: '665–713');
  static const yunmen = ZenMaster('Yunmen Wenyan', era: '864–949');
  static const zhaozhou = ZenMaster('Zhaozhou Congshen', era: '778–897');
}

/// Every line is traceable to a named work or a well-documented saying;
/// popular "Zen proverbs" with no source are deliberately left out.
const List<Quote> kQuotes = [
  // Dōgen
  Quote(
    id: 'dogen-study-self',
    master: Masters.dogen,
    source: 'Genjōkōan',
    en:
        'To study the Way is to study the self. '
        'To study the self is to forget the self.',
    es:
        'Estudiar el Camino es estudiarse a uno mismo. '
        'Estudiarse a uno mismo es olvidarse de uno mismo.',
  ),
  Quote(
    id: 'dogen-awakened-by-all',
    master: Masters.dogen,
    source: 'Genjōkōan',
    en: 'To forget the self is to be awakened by all things.',
    es: 'Olvidarse de uno mismo es ser despertado por todas las cosas.',
  ),
  Quote(
    id: 'dogen-flowers-weeds',
    master: Masters.dogen,
    source: 'Genjōkōan',
    en:
        'Flowers fall even though we love them; '
        'weeds grow even though we dislike them.',
    es:
        'Las flores caen aunque las amemos; '
        'la maleza crece aunque nos disguste.',
  ),
  Quote(
    id: 'dogen-firewood',
    master: Masters.dogen,
    source: 'Genjōkōan',
    en: 'Firewood becomes ash. It does not become firewood again.',
    es: 'La leña se vuelve ceniza. No vuelve a ser leña.',
  ),
  Quote(
    id: 'dogen-moon-water',
    master: Masters.dogen,
    source: 'Genjōkōan',
    en:
        'Awakening is like the moon reflected in water. '
        'The moon does not get wet, nor is the water broken.',
    es:
        'El despertar es como la luna reflejada en el agua. '
        'La luna no se moja ni el agua se rompe.',
  ),
  Quote(
    id: 'dogen-backward-step',
    master: Masters.dogen,
    source: 'Fukanzazengi',
    en: 'Take the backward step that turns the light inward.',
    es: 'Da el paso atrás que vuelve la luz hacia dentro.',
  ),
  Quote(
    id: 'dogen-time-flies',
    master: Masters.dogen,
    source: 'Uji',
    en: 'Do not think that time merely flies away.',
    es: 'No pienses que el tiempo simplemente se va volando.',
  ),

  // Sengcan
  Quote(
    id: 'sengcan-great-way',
    master: Masters.sengcan,
    source: 'Xinxin Ming',
    en: 'The Great Way is not difficult for those who do not pick and choose.',
    es: 'El Gran Camino no es difícil para quien no anda escogiendo.',
  ),
  Quote(
    id: 'sengcan-distinction',
    master: Masters.sengcan,
    source: 'Xinxin Ming',
    en:
        'Make the smallest distinction, '
        'and heaven and earth are set infinitely apart.',
    es:
        'Haz la menor distinción, '
        'y cielo y tierra quedan infinitamente separados.',
  ),
  Quote(
    id: 'sengcan-opinions',
    master: Masters.sengcan,
    source: 'Xinxin Ming',
    en: 'Do not search for the truth; only cease to cherish opinions.',
    es: 'No busques la verdad; solo deja de aferrarte a tus opiniones.',
  ),

  // Huineng
  Quote(
    id: 'huineng-not-a-thing',
    master: Masters.huineng,
    source: 'Liuzu Tanjing',
    en: 'Fundamentally there is not a single thing. Where could dust alight?',
    es: 'En el fondo no hay ni una sola cosa. ¿Dónde podría posarse el polvo?',
  ),
  Quote(
    id: 'huineng-flag',
    master: Masters.huineng,
    source: 'Wumenguan, 29',
    en:
        'It is not the wind that moves. It is not the flag that moves. '
        'It is your mind that moves.',
    es:
        'No se mueve el viento. No se mueve la bandera. '
        'Se mueve vuestra mente.',
  ),

  // Linji
  Quote(
    id: 'linji-ordinary',
    master: Masters.linji,
    source: 'Linji lu',
    en:
        'Just be ordinary: put on your robe, eat your food, '
        'and pass the time with nothing to do.',
    es:
        'Sé simplemente ordinario: ponte la ropa, come tu comida '
        'y pasa el tiempo sin nada que hacer.',
  ),
  Quote(
    id: 'linji-hungry-tired',
    master: Masters.linji,
    source: 'Linji lu',
    en:
        'When hungry, I eat; when tired, I sleep. '
        'Fools laugh at me. The wise understand.',
    es:
        'Cuando tengo hambre, como; cuando estoy cansado, duermo. '
        'Los necios se ríen de mí. Los sabios entienden.',
  ),

  // Zhaozhou
  Quote(
    id: 'zhaozhou-bowl',
    master: Masters.zhaozhou,
    source: 'Wumenguan, 7',
    en: 'Have you eaten your rice porridge? Then go wash your bowl.',
    es: '¿Ya comiste tus gachas de arroz? Entonces ve a lavar tu cuenco.',
  ),
  Quote(
    id: 'zhaozhou-cypress',
    master: Masters.zhaozhou,
    source: 'Wumenguan, 37',
    en:
        'A monk asked: “Why did Bodhidharma come from the West?”\n'
        'Zhaozhou said: “The cypress tree in the courtyard.”',
    es:
        'Un monje preguntó: «¿Por qué vino Bodhidharma del Oeste?»\n'
        'Zhaozhou dijo: «El ciprés en el patio».',
  ),
  Quote(
    id: 'zhaozhou-mu',
    master: Masters.zhaozhou,
    source: 'Wumenguan, 1',
    en:
        'A monk asked: “Does a dog have Buddha-nature?”\n'
        'Zhaozhou said: “Mu.”',
    es:
        'Un monje preguntó: «¿Tiene un perro naturaleza de Buda?»\n'
        'Zhaozhou dijo: «Mu».',
  ),

  // Tang-dynasty masters
  Quote(
    id: 'nanquan-ordinary-mind',
    master: Masters.nanquan,
    source: 'Wumenguan, 19',
    en: 'Ordinary mind is the Way.',
    es: 'La mente ordinaria es el Camino.',
  ),
  Quote(
    id: 'mazu-this-mind',
    master: Masters.mazu,
    source: 'Wumenguan, 30',
    en: 'This very mind is Buddha.',
    es: 'Esta misma mente es Buda.',
  ),
  Quote(
    id: 'yunmen-good-day',
    master: Masters.yunmen,
    source: 'Biyan lu, 6',
    en: 'Every day is a good day.',
    es: 'Cada día es un buen día.',
  ),
  Quote(
    id: 'huangbo-see-think',
    master: Masters.huangbo,
    source: 'Chuanxin fayao',
    en:
        'Fools shun what they see, not what they think. '
        'The wise shun what they think, not what they see.',
    es:
        'El necio rechaza lo que ve, no lo que piensa. '
        'El sabio rechaza lo que piensa, no lo que ve.',
  ),
  Quote(
    id: 'bodhidharma-vast-emptiness',
    master: Masters.bodhidharma,
    source: 'Biyan lu, 1',
    en: 'Vast emptiness. Nothing holy.',
    es: 'Vasto vacío. Nada sagrado.',
  ),
  Quote(
    id: 'pang-water-wood',
    master: Masters.pang,
    en:
        'My miraculous power and spiritual activity: '
        'drawing water and carrying firewood.',
    es:
        'Mi poder milagroso y mi actividad espiritual: '
        'sacar agua y cargar leña.',
  ),
  Quote(
    id: 'shitou-in-vain',
    master: Masters.shitou,
    source: 'Cantongqi',
    en: 'Do not pass your days and nights in vain.',
    es: 'No pases en vano tus días y tus noches.',
  ),
  Quote(
    id: 'yongjia-walking',
    master: Masters.yongjia,
    source: 'Zhengdao ge',
    en:
        'Walking is Zen, sitting is Zen. '
        'Speaking or silent, moving or still, the essence is at peace.',
    es:
        'Caminar es zen, sentarse es zen. '
        'Hablando o en silencio, en movimiento o en quietud, '
        'la esencia está en paz.',
  ),
  Quote(
    id: 'dongshan-flax',
    master: Masters.dongshanShouchu,
    source: 'Wumenguan, 18',
    en:
        'A monk asked: “What is Buddha?”\n'
        'Dongshan said: “Three pounds of flax.”',
    es:
        'Un monje preguntó: «¿Qué es Buda?»\n'
        'Dongshan dijo: «Tres libras de lino».',
  ),
  Quote(
    id: 'baizhang-work',
    master: Masters.baizhang,
    en: 'A day without work is a day without food.',
    es: 'Un día sin trabajar es un día sin comer.',
  ),
  Quote(
    id: 'qingyuan-mountains',
    master: Masters.qingyuan,
    source: 'Wudeng huiyuan',
    en:
        'Before I studied Zen, mountains were mountains and rivers were rivers. '
        'Then mountains were no longer mountains, nor rivers rivers. '
        'Now that I am at rest, mountains are once again mountains, '
        'and rivers once again rivers.',
    es:
        'Antes de estudiar zen, las montañas eran montañas y los ríos eran ríos. '
        'Después, las montañas ya no eran montañas ni los ríos, ríos. '
        'Ahora que descanso, las montañas vuelven a ser montañas, '
        'y los ríos, ríos.',
  ),

  // Wumen
  Quote(
    id: 'wumen-seasons',
    master: Masters.wumen,
    source: 'Wumenguan, 19',
    en:
        'Spring flowers, autumn moon; summer breeze, winter snow. '
        'If useless things do not clutter your mind, '
        'this is the best season of your life.',
    es:
        'Flores en primavera, luna en otoño; brisa en verano, nieve en invierno. '
        'Si las cosas inútiles no ocupan tu mente, '
        'esta es la mejor estación de tu vida.',
  ),
  Quote(
    id: 'wumen-no-gate',
    master: Masters.wumen,
    source: 'Wumenguan',
    en: 'The Great Way has no gate; a thousand roads enter it.',
    es: 'El Gran Camino no tiene puerta; mil senderos llegan a él.',
  ),

  // Japan
  Quote(
    id: 'hakuin-water-ice',
    master: Masters.hakuin,
    source: 'Zazen wasan',
    en:
        'All beings are, from the very beginning, Buddhas. '
        'It is like water and ice: apart from water, there is no ice.',
    es:
        'Todos los seres son, desde el principio, budas. '
        'Es como el agua y el hielo: sin agua no hay hielo.',
  ),
  Quote(
    id: 'hakuin-near',
    master: Masters.hakuin,
    source: 'Zazen wasan',
    en: 'Not knowing how near the truth is, we seek it far away. What a pity!',
    es: 'Sin saber cuán cerca está la verdad, la buscamos lejos. ¡Qué lástima!',
  ),
  Quote(
    id: 'hakuin-one-hand',
    master: Masters.hakuin,
    en: 'What is the sound of one hand?',
    es: '¿Cuál es el sonido de una sola mano?',
  ),
  Quote(
    id: 'bankei-unborn',
    master: Masters.bankei,
    en: 'Everything is perfectly resolved in the Unborn.',
    es: 'Todo queda perfectamente resuelto en lo No Nacido.',
  ),
  Quote(
    id: 'ryokan-thief',
    master: Masters.ryokan,
    en: 'The thief left it behind:\nthe moon at my window.',
    es: 'El ladrón la dejó atrás:\nla luna en mi ventana.',
  ),
  Quote(
    id: 'ryokan-lazy',
    master: Masters.ryokan,
    en:
        'Too lazy for ambition, I leave the world to itself. '
        'In my bag, rice for ten days; by the hearth, a bundle of twigs.',
    es:
        'Demasiado perezoso para la ambición, dejo el mundo a su aire. '
        'En mi saco, arroz para diez días; junto al fuego, un manojo de ramas.',
  ),

  // Twentieth century
  Quote(
    id: 'suzuki-beginner',
    master: Masters.suzuki,
    source: 'Zen Mind, Beginner’s Mind',
    en:
        'In the beginner’s mind there are many possibilities, '
        'but in the expert’s there are few.',
    es:
        'En la mente del principiante hay muchas posibilidades; '
        'en la del experto, pocas.',
  ),
  Quote(
    id: 'sawaki-good-for-nothing',
    master: Masters.sawaki,
    en: 'Zazen is good for nothing.',
    es: 'Zazen no sirve para nada.',
  ),
];
