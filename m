Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552A433F00B
	for <lists+linux-scsi@lfdr.de>; Wed, 17 Mar 2021 13:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhCQMMR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 17 Mar 2021 08:12:17 -0400
Received: from m42-10.mailgun.net ([69.72.42.10]:11868 "EHLO
        m42-10.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhCQMMG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 17 Mar 2021 08:12:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615983125; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=LTIBg0w55xOXk1pOPZGrIdiuibgse0XRpR2wxcb2toQ=;
 b=l9Rav9vak26/F0EoFki5oiWpZyb4DBfwX7W67BxgrGB53DYsuycPU20rPawTA1OiD+X5U3kr
 w9cxLwPMfNzgASuM0G+AbWIjSU0zydgiJUM+xAO+rGwb1ZFHtciazkFatpU7HLFPfUMnr8p0
 6tWgvVcGCXyhUjfIw0iGrb6jPhY=
X-Mailgun-Sending-Ip: 69.72.42.10
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6051f2144db3bb68017be316 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Mar 2021 12:12:04
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E241BC433C6; Wed, 17 Mar 2021 12:12:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8DB64C433CA;
        Wed, 17 Mar 2021 12:12:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 17 Mar 2021 20:12:02 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, Bart Van Assche <bvanassche@acm.org>,
        yongmyung lee <ymhungry.lee@samsung.com>,
        Daejun Park <daejun7.park@samsung.com>,
        alim.akhtar@samsung.com, asutoshd@codeaurora.org,
        Zang Leigang <zangleigang@hisilicon.com>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        Bean Huo <beanhuo@micron.com>, stanley.chu@mediatek.com
Subject: Re: [PATCH v5 06/10] scsi: ufshpb: Add hpb dev reset response
In-Reply-To: <DM6PR04MB6575006E0682C3D11F54965DFC6A9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210302132503.224670-1-avri.altman@wdc.com>
 <20210302132503.224670-7-avri.altman@wdc.com>
 <59a62fc17ec9229a8498e696eb0474be@codeaurora.org>
 <DM6PR04MB6575006E0682C3D11F54965DFC6A9@DM6PR04MB6575.namprd04.prod.outlook.com>
Message-ID: <1d0e3c5441ecf14b6614ec0af0d30af6@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2021-03-17 19:23, Avri Altman wrote:
>> 
>> On 2021-03-02 21:24, Avri Altman wrote:
>> > The spec does not define what is the host's recommended response when
>> > the device send hpb dev reset response (oper 0x2).
>> >
>> > We will update all active hpb regions: mark them and do that on the
>> > next
>> > read.
>> >
>> > Signed-off-by: Avri Altman <avri.altman@wdc.com>
>> > ---
>> >  drivers/scsi/ufs/ufshpb.c | 47
>> ++++++++++++++++++++++++++++++++++++---
>> >  drivers/scsi/ufs/ufshpb.h |  2 ++
>> >  2 files changed, 46 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
>> > index 0744feb4d484..0034fa03fdc6 100644
>> > --- a/drivers/scsi/ufs/ufshpb.c
>> > +++ b/drivers/scsi/ufs/ufshpb.c
>> > @@ -642,7 +642,8 @@ int ufshpb_prep(struct ufs_hba *hba, struct
>> > ufshcd_lrb *lrbp)
>> >               if (rgn->reads == ACTIVATION_THRESHOLD)
>> >                       activate = true;
>> >               spin_unlock_irqrestore(&rgn->rgn_lock, flags);
>> > -             if (activate) {
>> > +             if (activate ||
>> > +                 test_and_clear_bit(RGN_FLAG_UPDATE, &rgn->rgn_flags)) {
>> >                       spin_lock_irqsave(&hpb->rsp_list_lock, flags);
>> >                       ufshpb_update_active_info(hpb, rgn_idx, srgn_idx);
>> >                       hpb->stats.rb_active_cnt++;
>> > @@ -1480,6 +1481,20 @@ void ufshpb_rsp_upiu(struct ufs_hba *hba,
>> > struct ufshcd_lrb *lrbp)
>> >       case HPB_RSP_DEV_RESET:
>> >               dev_warn(&hpb->sdev_ufs_lu->sdev_dev,
>> >                        "UFS device lost HPB information during PM.\n");
>> > +
>> > +             if (hpb->is_hcm) {
>> > +                     struct scsi_device *sdev;
>> > +
>> > +                     __shost_for_each_device(sdev, hba->host) {
>> > +                             struct ufshpb_lu *h = sdev->hostdata;
>> > +
>> > +                             if (!h)
>> > +                                     continue;
>> > +
>> > +                             schedule_work(&hpb->ufshpb_lun_reset_work);
>> > +                     }
>> > +             }
>> > +
>> >               break;
>> >       default:
>> >               dev_notice(&hpb->sdev_ufs_lu->sdev_dev,
>> > @@ -1594,6 +1609,25 @@ static void
>> > ufshpb_run_inactive_region_list(struct ufshpb_lu *hpb)
>> >       spin_unlock_irqrestore(&hpb->rsp_list_lock, flags);
>> >  }
>> >
>> > +static void ufshpb_reset_work_handler(struct work_struct *work)
>> 
>> Just curious, directly doing below things inside ufshpb_rsp_upiu() 
>> does
>> not
>> seem a problem to me, does this really deserve a separate work?
> I don't know, I never even consider of doing this.
> The active region list may contain up to few thousands of regions -
> It is not rare to see configurations that covers the entire device.
> 

Yes, true, it can be a huge list. But what does the ops 
"HPB_RSP_DEV_RESET"
really mean? The specs says "Device reset HPB Regions information", but 
I
don't know what is really happening. Could you please elaborate?

Thanks,
Can Guo.

> But yes, I can do that.
> Better to get ack from Daejun first.
> 
> Thanks,
> Avri
> 
>> 
>> Thanks,
>> Can Guo.
>> 
>> > +{
>> > +     struct ufshpb_lu *hpb;
>> > +     struct victim_select_info *lru_info;
>> > +     struct ufshpb_region *rgn;
>> > +     unsigned long flags;
>> > +
>> > +     hpb = container_of(work, struct ufshpb_lu, ufshpb_lun_reset_work);
>> > +
>> > +     lru_info = &hpb->lru_info;
>> > +
>> > +     spin_lock_irqsave(&hpb->rgn_state_lock, flags);
>> > +
>> > +     list_for_each_entry(rgn, &lru_info->lh_lru_rgn, list_lru_rgn)
>> > +             set_bit(RGN_FLAG_UPDATE, &rgn->rgn_flags);
>> > +
>> > +     spin_unlock_irqrestore(&hpb->rgn_state_lock, flags);
>> > +}
>> > +
>> >  static void ufshpb_normalization_work_handler(struct work_struct
>> > *work)
>> >  {
>> >       struct ufshpb_lu *hpb;
>> > @@ -1798,6 +1832,8 @@ static int ufshpb_alloc_region_tbl(struct
>> > ufs_hba *hba, struct ufshpb_lu *hpb)
>> >               } else {
>> >                       rgn->rgn_state = HPB_RGN_INACTIVE;
>> >               }
>> > +
>> > +             rgn->rgn_flags = 0;
>> >       }
>> >
>> >       return 0;
>> > @@ -2012,9 +2048,12 @@ static int ufshpb_lu_hpb_init(struct ufs_hba
>> > *hba, struct ufshpb_lu *hpb)
>> >       INIT_LIST_HEAD(&hpb->list_hpb_lu);
>> >
>> >       INIT_WORK(&hpb->map_work, ufshpb_map_work_handler);
>> > -     if (hpb->is_hcm)
>> > +     if (hpb->is_hcm) {
>> >               INIT_WORK(&hpb->ufshpb_normalization_work,
>> >                         ufshpb_normalization_work_handler);
>> > +             INIT_WORK(&hpb->ufshpb_lun_reset_work,
>> > +                       ufshpb_reset_work_handler);
>> > +     }
>> >
>> >       hpb->map_req_cache = kmem_cache_create("ufshpb_req_cache",
>> >                         sizeof(struct ufshpb_req), 0, 0, NULL);
>> > @@ -2114,8 +2153,10 @@ static void ufshpb_discard_rsp_lists(struct
>> > ufshpb_lu *hpb)
>> >
>> >  static void ufshpb_cancel_jobs(struct ufshpb_lu *hpb)
>> >  {
>> > -     if (hpb->is_hcm)
>> > +     if (hpb->is_hcm) {
>> > +             cancel_work_sync(&hpb->ufshpb_lun_reset_work);
>> >               cancel_work_sync(&hpb->ufshpb_normalization_work);
>> > +     }
>> >       cancel_work_sync(&hpb->map_work);
>> >  }
>> >
>> > diff --git a/drivers/scsi/ufs/ufshpb.h b/drivers/scsi/ufs/ufshpb.h
>> > index 84598a317897..37c1b0ea0c0a 100644
>> > --- a/drivers/scsi/ufs/ufshpb.h
>> > +++ b/drivers/scsi/ufs/ufshpb.h
>> > @@ -121,6 +121,7 @@ struct ufshpb_region {
>> >       struct list_head list_lru_rgn;
>> >       unsigned long rgn_flags;
>> >  #define RGN_FLAG_DIRTY 0
>> > +#define RGN_FLAG_UPDATE 1
>> >
>> >       /* region reads - for host mode */
>> >       spinlock_t rgn_lock;
>> > @@ -217,6 +218,7 @@ struct ufshpb_lu {
>> >       /* for selecting victim */
>> >       struct victim_select_info lru_info;
>> >       struct work_struct ufshpb_normalization_work;
>> > +     struct work_struct ufshpb_lun_reset_work;
>> >
>> >       /* pinned region information */
>> >       u32 lu_pinned_start;
