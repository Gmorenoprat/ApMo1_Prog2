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
    float canAttackTimer = 0f;
    PlayerController _control;
    Movement _movement;
    BattleMechanics _battleMechanics;
    CheckpointMananger _checkpointMananger;




    private void Start()
    {
        _movement = new Movement(this);
        _battleMechanics = new BattleMechanics(this);
        _checkpointMananger = new CheckpointMananger(this);
        _control = new PlayerController(this, _movement, _battleMechanics, _checkpointMananger);
  
    }

    private void Update()
    {
        _control.OnUpdate();


        if (canAttackTimer <= 0) { canAttack = true; AttackRange.enabled = false; }
            canAttackTimer -= Time.deltaTime;

        if (Input.GetKeyDown(KeyCode.F)) { GetHit(); }//Sacar esto 
    }

    public bool IsGrounded{
        get {return isGrounded; }
        set {isGrounded = value; } 
    }

    public bool CanAttack
    {
        get { return canAttack; }
        set { canAttack = value; }
    }
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

    public void GetHp(int hp)
    {
        this.life += hp;
        if (life > _maxLifes) life = _maxLifes;
    }

    public void GetShield(int a)
    {
        shieldOn = true;
        prefabShield.gameObject.SetActive(true);
    }
}