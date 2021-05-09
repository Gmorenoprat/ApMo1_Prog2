using UnityEngine;

public class Player : MonoBehaviour
{
    public float speed;
    public bool isGrounded;
    public bool canAttack;
    float canAttackTimer = 0f;
    PlayerController _control;
    Movement _movement;
    BattleMechanics _battleMechanics;




    private void Start()
    {
        _movement = new Movement(this);
        _battleMechanics = new BattleMechanics(this);
        _control = new PlayerController(_movement, _battleMechanics);
  
    }

    private void Update()
    {
        _control.OnUpdate();


        if (canAttackTimer <= 0) canAttack = true;
        canAttackTimer -= Time.deltaTime;

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
        canAttackTimer = 1f;
    }
    public void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.tag == "Floor") { IsGrounded = true; }
    }
}