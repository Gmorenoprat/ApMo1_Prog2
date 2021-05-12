using System.Collections;
using UnityEngine;

public class Player : MonoBehaviour ,ICollector
{
    public float speed;
    public bool isGrounded;
    public bool canAttack;
    public bool shieldOn = false;
    public GameObject prefabShield;
    public Collider AttackRange;
    public int life = 3;
    int _maxLifes = 3;
    public bool invencibility = false;
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

    public void GetHit(int damage)
    {
        _soundMananger.SoundPlay((int)2);
        if (shieldOn)
        {
            prefabShield.gameObject.SetActive(false);
            shieldOn = false;
            return;
        }
        if (!invencibility) life -= damage;
        StartCoroutine(Invencibility());
        if (life <= 0)
        {
            this.GetComponent<Animator>().SetBool("isDead", true);
            this.enabled = false;
        }
        this.GetComponent<Animator>().SetTrigger("getHit");

    }

    public IEnumerator Invencibility()
    {
        invencibility = true;
        yield return new WaitForSeconds(1);
        invencibility = false;
        yield return null;
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
    #region Checkpoint
    internal void SaveCheckPoint()
    {
        _control.SaveCheckPoint();
    }
    internal void LoadCheckPoint()
    {
        _control.LoadCheckPoint();
    }
    #endregion

}