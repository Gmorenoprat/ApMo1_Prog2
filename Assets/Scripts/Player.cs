using UnityEngine;

public class Player : MonoBehaviour ,ICollector
{
    public float speed;
    public bool isGrounded;
    public bool canAttack;
    public bool shieldOn;
    public GameObject prefabShield;
    public Collider AttackRange;
    public int life = 3;
    int _maxLifes = 3;
    public int apples = 0;
    float canAttackTimer = 0f;
    PlayerController _control;
    Movement _movement;
    BattleMechanics _battleMechanics;
    CheckpointMananger _checkpointMananger;
    SoundMananger _soundMananger;
    public AudioClip[] ClipsAudio;

    private void Start()
    {
        _movement = new Movement(this);
        _battleMechanics = new BattleMechanics(this);
        _checkpointMananger = new CheckpointMananger(this);
        _soundMananger = new SoundMananger(this);
        _control = new PlayerController(this, _movement, _battleMechanics, _checkpointMananger, _soundMananger);
  
    }

    private void Update()
    {
        _control.OnUpdate();


        if (canAttackTimer <= 0) { canAttack = true; AttackRange.enabled = false; }
            canAttackTimer -= Time.deltaTime;

        if (Input.GetKeyDown(KeyCode.F)) { GetHit(); _soundMananger.SoundPlay((int)2);}//Sacar esto 
    }

    #region Properties
    public bool IsGrounded{
        get {return isGrounded; }
        set {isGrounded = value; } 
    }

    public bool CanAttack
    {
        get { return canAttack; }
        set { canAttack = value; }
    }
    #endregion
    public void ResetTimerAttack()
    {
        canAttackTimer = 0.6f;

    }
    public void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.tag == "Floor") { IsGrounded = true; }
    }

    public void GetHit()
    {
        life -= 1;
        if (life <= 0)
        {
            this.GetComponent<Animator>().SetBool("isDead", true);
        }
        this.GetComponent<Animator>().SetTrigger("getHit");

    }


    #region CollectableGetters
    public void GetHp(int hp)
    {
        this.life += hp;
        if (life > _maxLifes) life = _maxLifes;
    }

    public void GetShield()
    {
        shieldOn = true;
        prefabShield.gameObject.SetActive(true);
    } 
    public void GetApple()
    {
        this.apples += 1;
    }
    #endregion
}