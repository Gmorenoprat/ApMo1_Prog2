using UnityEngine;

public class BattleMechanics 
{
    Player _player;
    Animator _anim;
    public BattleMechanics(Player p)
    {
        _player = p;
        _anim = _player.GetComponent<Animator>();
    }

    public void Attack()
    {
        if (!_player.CanAttack) return;
        _player.CanAttack = false;
        _anim.SetTrigger("Attack");
        _player.ResetTimerAttack();
        _player.AttackRange.enabled = true;

    }

}
