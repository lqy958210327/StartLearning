using UnityEngine;

public class IceTower : TowerBase
{
    public float slowAmount = 0.5f; // 减速百分比

    protected override void Attack(Vector3 targetPosition)
    {
        base.Attack(targetPosition);
        // 这里可以添加额外的逻辑，比如发射带有减速效果的子弹
        // 或者在子弹命中敌人时应用减速效果
    }

    // 可以添加额外的方法来处理减速效果，比如一个定时器来检查并应用减速
}