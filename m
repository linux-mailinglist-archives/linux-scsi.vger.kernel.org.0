Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D33F33E936
	for <lists+linux-scsi@lfdr.de>; Wed, 17 Mar 2021 06:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhCQFsO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 17 Mar 2021 01:48:14 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:16780 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhCQFsE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 17 Mar 2021 01:48:04 -0400
Received: from epcas3p2.samsung.com (unknown [182.195.41.20])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210317054802epoutp03e8cf0556a9c975072e500c617c130dce~tCyImfnvj2408224082epoutp03g
        for <linux-scsi@vger.kernel.org>; Wed, 17 Mar 2021 05:48:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210317054802epoutp03e8cf0556a9c975072e500c617c130dce~tCyImfnvj2408224082epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615960082;
        bh=DAufh9kyi6EFk8KZ91XXVnd5iZ7oRqbdIpDV4FDL/Ew=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=LJpvwyX9hJFAjFr8reoO7nvEhkIt1wieRelpVgyAuBjkjUJ2AnecLJ/XmTCTspVSR
         d0+ldxKvNfvFzKXVoDblTMy1hqvmEaTtcXy21tc4MBAy+u9tzh/DxSdaFNPyCvBDoL
         WAG2yYMma30Uq6uQYHyvKK+vm1EuD6Ki+QMt16DQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas3p4.samsung.com (KnoxPortal) with ESMTP id
        20210317054801epcas3p4c602d67aea37dd24ad734ecbb1ff396e~tCyH8t6Y51304013040epcas3p4T;
        Wed, 17 Mar 2021 05:48:01 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp1.localdomain
        (Postfix) with ESMTP id 4F0fMP673gz4x9QQ; Wed, 17 Mar 2021 05:48:01 +0000
        (GMT)
Mime-Version: 1.0
Subject: RE: Re: [PATCH v5 05/10] scsi: ufshpb: Region inactivation in host
 mode
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     Can Guo <cang@codeaurora.org>,
        Daejun Park <daejun7.park@samsung.com>
CC:     Avri Altman <Avri.Altman@wdc.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        yongmyung lee <ymhungry.lee@samsung.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        Zang Leigang <zangleigang@hisilicon.com>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <a5958ce2eca11b6ddcf75fa3aeeaaa4f@codeaurora.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <2038148563.21615960081843.JavaMail.epsvc@epcpadp4>
Date:   Wed, 17 Mar 2021 14:42:37 +0900
X-CMS-MailID: 20210317054237epcms2p64f0a74b8862788b06dcd84b2a2775c5d
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20210316083014epcas2p32d6b84e689cdbe06ee065c870b236d65
References: <a5958ce2eca11b6ddcf75fa3aeeaaa4f@codeaurora.org>
        <064483451ff0d9ef8703871332ea5c3b@codeaurora.org>
        <DM6PR04MB65751EE32D25C7E57A6BABE8FC6B9@DM6PR04MB6575.namprd04.prod.outlook.com>
        <20210302132503.224670-1-avri.altman@wdc.com>
        <20210302132503.224670-6-avri.altman@wdc.com>
        <25da7378d5bf4c52443ae9b47f3fd778@codeaurora.org>
        <57afb2b5d7edda61a40493d8545785b1@codeaurora.org>
        <2038148563.21615949282962.JavaMail.epsvc@epcpadp4>
        <1796371666.41615958582147.JavaMail.epsvc@epcpadp4>
        <CGME20210316083014epcas2p32d6b84e689cdbe06ee065c870b236d65@epcms2p6>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

>>>>>> >> ---
>>>>>> >>  drivers/scsi/ufs/ufshpb.c | 14 ++++++++++++++
>>>>>> >>  drivers/scsi/ufs/ufshpb.h |  1 +
>>>>>> >>  2 files changed, 15 insertions(+)
>>>>>> >>
>>>>>> >> diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
>>>>>> >> index 6f4fd22eaf2f..0744feb4d484 100644
>>>>>> >> --- a/drivers/scsi/ufs/ufshpb.c
>>>>>> >> +++ b/drivers/scsi/ufs/ufshpb.c
>>>>>> >> @@ -907,6 +907,7 @@ static int ufshpb_execute_umap_req(struct
>>>>>> >> ufshpb_lu *hpb,
>>>>>> >>
>>>>>> >>      blk_execute_rq_nowait(q, NULL, req, 1, ufshpb_umap_req_compl_fn);
>>>>>> >>
>>>>>> >> +    hpb->stats.umap_req_cnt++;
>>>>>> >>      return 0;
>>>>>> >>  }
>>>>>> >>
>>>>>> >> @@ -1103,6 +1104,12 @@ static int ufshpb_issue_umap_req(struct
>>>>>> >> ufshpb_lu *hpb,
>>>>>> >>      return -EAGAIN;
>>>>>> >>  }
>>>>>> >>
>>>>>> >> +static int ufshpb_issue_umap_single_req(struct ufshpb_lu *hpb,
>>>>>> >> +                                    struct ufshpb_region *rgn)
>>>>>> >> +{
>>>>>> >> +    return ufshpb_issue_umap_req(hpb, rgn);
>>>>>> >> +}
>>>>>> >> +
>>>>>> >>  static int ufshpb_issue_umap_all_req(struct ufshpb_lu *hpb)
>>>>>> >>  {
>>>>>> >>      return ufshpb_issue_umap_req(hpb, NULL);
>>>>>> >> @@ -1115,6 +1122,10 @@ static void __ufshpb_evict_region(struct
>>>>>> >> ufshpb_lu *hpb,
>>>>>> >>      struct ufshpb_subregion *srgn;
>>>>>> >>      int srgn_idx;
>>>>>> >>
>>>>>> >> +
>>>>>> >> +    if (hpb->is_hcm && ufshpb_issue_umap_single_req(hpb, rgn))
>>>>>> >
>>>>>> > __ufshpb_evict_region() is called with rgn_state_lock held and IRQ
>>>>>> > disabled,
>>>>>> > when ufshpb_issue_umap_single_req() invokes blk_execute_rq_nowait(),
>>>>>> > below
>>>>>> > warning shall pop up every time, fix it?
>>>>>> >
>>>>>> > void blk_execute_rq_nowait(struct request_queue *q, struct gendisk
>>>>>> > *bd_disk,
>>>>>> >                  struct request *rq, int at_head,
>>>>>> >                          rq_end_io_fn *done)
>>>>>> > {
>>>>>> >       WARN_ON(irqs_disabled());
>>>>>> > ...
>>>>>> >
>>>>>> 
>>>>>> Moreover, since we are here with rgn_state_lock held and IRQ
>>>>>> disabled,
>>>>>> in ufshpb_get_req(), rq = kmem_cache_alloc(hpb->map_req_cache,
>>>>>> GFP_KERNEL)
>>>>>> has the GFP_KERNEL flag, scheduling while atomic???
>>>>> I think your comment applies to  ufshpb_issue_umap_all_req as well,
>>>>> Which is called from slave_configure/scsi_add_lun.
>>>>> 
>>>>> Since the host-mode series is utilizing the framework laid by the
>>>>> device-mode,
>>>>> Maybe you can add this comment to  Daejun's last version?
>>>> 
>>>> Hi Avri, Can Guo
>>>> 
>>>> I think ufshpb_issue_umap_single_req() can be moved to end of
>>>> ufshpb_evict_region().
>>>> Then we can avoid rgn_state_lock when it sends unmap command.
>>> 
>>> I am not the expert here, please you two fix it. I am just reporting
>>> what can be wrong. Anyways, ufshpb_issue_umap_single_req() should not
>>> be called with rgn_state_lock held - think about below (another 
>>> deadly)
>>> scenario.
>>> 
>>> lock(rgn_state_lock)
>>>   ufshpb_issue_umap_single_req()
>>>     ufshpb_prep()
>>>        lock(rgn_state_lock)   <---------- recursive spin_lock
>>> 
>>> BTW, @Daejun shouldn't we stop passthrough cmds from stepping
>>> into ufshpb_prep()? In current code, you are trying to use below
>>> check to block cmds other than write/discard/read, but a passthrough
>>> cmd can not be blocked by the check.
>>> 
>>>          if (!ufshpb_is_write_or_discard_cmd(cmd) &&
>>>              !ufshpb_is_read_cmd(cmd) )
>>>                  return 0;
>> 
>> I found this problem too. I fixed it and submit next patch.
> 
>You mean in V30, which has not been uploaded yet, right?

Yes, it is about v30.

Thanks,
Daejun

>Thanks,
>Can Guo.
> 
>> 
>> if (blk_rq_is_scsi(cmd->request) ||
>>             (!ufshpb_is_write_or_discard_cmd(cmd) &&
>>             !ufshpb_is_read_cmd(cmd)))
>>                 return 0;
>> 
>> 
>> Thanks,
>> Daejun
>> 
>>> Thanks,
>>> Can Guo.
>>> 
>>>> 
>>>> Thanks,
>>>> Daejun
>>>> 
>>>> 
>>>>> Thanks,
>>>>> Avri
>>>>> 
>>>>>> 
>>>>>> Can Guo.
>>>>>> 
>>>>>> > Thanks.
>>>>>> > Can Guo.
>>>>>> >
>>>>>> >> +            return;
>>>>>> >> +
>>>>>> >>      lru_info = &hpb->lru_info;
>>>>>> >>
>>>>>> >>      dev_dbg(&hpb->sdev_ufs_lu->sdev_dev, "evict region %d\n",
>>>>>> >> rgn->rgn_idx);
>>>>>> >> @@ -1855,6 +1866,7 @@ ufshpb_sysfs_attr_show_func(rb_noti_cnt);
>>>>>> >>  ufshpb_sysfs_attr_show_func(rb_active_cnt);
>>>>>> >>  ufshpb_sysfs_attr_show_func(rb_inactive_cnt);
>>>>>> >>  ufshpb_sysfs_attr_show_func(map_req_cnt);
>>>>>> >> +ufshpb_sysfs_attr_show_func(umap_req_cnt);
>>>>>> >>
>>>>>> >>  static struct attribute *hpb_dev_stat_attrs[] = {
>>>>>> >>      &dev_attr_hit_cnt.attr,
>>>>>> >> @@ -1863,6 +1875,7 @@ static struct attribute *hpb_dev_stat_attrs[] =
>>>>>> >> {
>>>>>> >>      &dev_attr_rb_active_cnt.attr,
>>>>>> >>      &dev_attr_rb_inactive_cnt.attr,
>>>>>> >>      &dev_attr_map_req_cnt.attr,
>>>>>> >> +    &dev_attr_umap_req_cnt.attr,
>>>>>> >>      NULL,
>>>>>> >>  };
>>>>>> >>
>>>>>> >> @@ -1978,6 +1991,7 @@ static void ufshpb_stat_init(struct ufshpb_lu
>>>>>> >> *hpb)
>>>>>> >>      hpb->stats.rb_active_cnt = 0;
>>>>>> >>      hpb->stats.rb_inactive_cnt = 0;
>>>>>> >>      hpb->stats.map_req_cnt = 0;
>>>>>> >> +    hpb->stats.umap_req_cnt = 0;
>>>>>> >>  }
>>>>>> >>
>>>>>> >>  static void ufshpb_param_init(struct ufshpb_lu *hpb)
>>>>>> >> diff --git a/drivers/scsi/ufs/ufshpb.h b/drivers/scsi/ufs/ufshpb.h
>>>>>> >> index bd4308010466..84598a317897 100644
>>>>>> >> --- a/drivers/scsi/ufs/ufshpb.h
>>>>>> >> +++ b/drivers/scsi/ufs/ufshpb.h
>>>>>> >> @@ -186,6 +186,7 @@ struct ufshpb_stats {
>>>>>> >>      u64 rb_inactive_cnt;
>>>>>> >>      u64 map_req_cnt;
>>>>>> >>      u64 pre_req_cnt;
>>>>>> >> +    u64 umap_req_cnt;
>>>>>> >>  };
>>>>>> >>
>>>>>> >>  struct ufshpb_lu {
>>>>> 
>>>>> 
>>>>> 
>>> 
>>> 
>>> 
> 
> 
>  
