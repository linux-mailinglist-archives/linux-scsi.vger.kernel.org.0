Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B9B33A990
	for <lists+linux-scsi@lfdr.de>; Mon, 15 Mar 2021 03:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhCOCU0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 14 Mar 2021 22:20:26 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:19616 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhCOCT5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 14 Mar 2021 22:19:57 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210315021955epoutp03d0a188b6cdb9855c7c4f88f585d3a30e~sYp2xTsvg1664016640epoutp03d
        for <linux-scsi@vger.kernel.org>; Mon, 15 Mar 2021 02:19:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210315021955epoutp03d0a188b6cdb9855c7c4f88f585d3a30e~sYp2xTsvg1664016640epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615774795;
        bh=0dBtRtoOshQms2tpXGh6/J26HsERNaXLlFcuGtaC70o=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=hGlmp2ZEXguyLOB3NflGBXtFJVv2ghXzN4uwxHmX9jpe/JwXcb5+iy5yTNIfXxKQl
         K6Btqi5GwNlMPfq/a94L+LgQrrbI/MrCm8frEXPMX2cybgAcX/B36du9yRx6EEGL7f
         sWZE805yEjcSrrbHDxzlTL3pw0EnpNT4h96UGEfk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20210315021955epcas2p38ece26392e3231e548598238af9d32c0~sYp2UJHLg3052030520epcas2p3z;
        Mon, 15 Mar 2021 02:19:55 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.182]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DzKr84DZXz4x9Q0; Mon, 15 Mar
        2021 02:19:52 +0000 (GMT)
X-AuditID: b6c32a48-50fff7000000cd1f-22-604ec448630e
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.C8.52511.844CE406; Mon, 15 Mar 2021 11:19:52 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH v26 2/4] scsi: ufs: L2P map management for HPB read
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     Can Guo <cang@codeaurora.org>,
        Daejun Park <daejun7.park@samsung.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "huobean@gmail.com" <huobean@gmail.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        JinHwan Park <jh.i.park@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>,
        SEUNGUK SHIN <seunguk.shin@samsung.com>,
        Sung-Jun Park <sungjun07.park@samsung.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        BoRam Shin <boram.shin@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <f06e9ef0412f14477099cf4b92b5dfde@codeaurora.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210315021951epcms2p5bc71f4d0b96c985bb3655b1aa0dc84ea@epcms2p5>
Date:   Mon, 15 Mar 2021 11:19:51 +0900
X-CMS-MailID: 20210315021951epcms2p5bc71f4d0b96c985bb3655b1aa0dc84ea
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA52TfUxTZxTGfe/tFyx11wruBZNZL5uRr9KWtr44YMQpu8bANqObmdvgrlwp
        Edp6W4jgMrpo+QY1ZGA66hbMYCJbgVEsMIMCc2yG4WBsfAsOspjAUNAxENjoB9Psz/33y5Pn
        nPOc8+YV4KJWvr8gRWtkWC2dSvK8OU0dgcpQqjM+UTo264/GLzbx0LWcLj66t9jPQx3Df/BR
        2f1FHM3ZqrjoXnsgqhl/C52+ZOOhim4ThorP2nnot5F5PqocaMLQ2dVcDuprqeChwl8dPFT9
        3SqGhhu90ef2QYDyy2s5MT5U388HqL6SYoxqtozyqXOV1wHVZq3lU2e+b+NQD6aGOFRJYw2g
        5huep3KvF2Kve79tApE0q9akZDBiRqvWJaVok6PIw4diQxEp1ugMxijyqAzJJbIIpUQRIZHv
        ene3TCqVK0mxlk5josiToZ5qUsyq9WtuI2MwsoyaWZPYGIORTmYkBjrNkK5Nlqh1aaQ4g05N
        X6sjw6IjNQydxLDixEmgKbyxwNefHwQnl1f/BCbQXAYKgJcAEgpY3u3AC4C3QEQ4AJyrKOMW
        AIFASGyCK47NTs9m4gAs63zMdbKIIKHtJwvfrUvg0EStqw+PCIHlXXdcug+xHz4qvcJ19sSJ
        ah78qKqN6x4mhBdypzhu3gqvVttdxV5ENBye7vIE2gn/qirG3ewLB6/M8Nd59uanHo8PNI91
        ezyb4Phiq0f3gzdb72Nuzob2kSXgDAGJIgA7moc8IcLgL3n1rhBCIg5eyn/EczKHeBGujEzw
        3J690NyR42qEE9vg1ZkK3HkUnAiEtpYwJ0IiAHYOcdbXMtU/5v+XcWIjzOtY+Vd3XJz0RNsB
        v1q0YedAgOXJpS1PzbI8mfUZwGvAFkZvSEtmDHK94umnbgCuDxBEOcAnM/cl7QATgHYABTjp
        I5wPiUsUCZPozCyG1SWw6amMoR1krW15Hvf3VevWfpDWmCBTSeUqZbgiPFypUP5vWSlXqaQR
        SqRUyRH5nJCVjieIiGTayBxnGD3Drg/HBF7+JiwxJr6v0ay23Ai2d5o3auvqr82+9m3vsn5O
        8EHWF0f9vnl1xI8e3DNjzmAf0tleE/KXNVrf9yCwdm7QmXX5O+Z7juvF6iQ/7uizD7tSb21Q
        9J/Cvo6VHslTrfiEiEaltbXVH/ay+ds/Xq459kLQIXndnYjRtC+32fGxHFEjZ3mPda9lObqo
        PDP4oKmg0Dp85HZgKX8XR6ucbsst2XdrOxw6sZStCHjHgNX2XjCSJybH7prf/N02UDldcjiw
        7octW3efOSgUDgSXlj7TE9+fieSxCy13G+Q7X3mAVYiOvd8yVRUZl1i039qbGLZklFVRpy7/
        /YZ14aXTP96mTHlegp7L8yTHoKFlQThroP8BVPbEBc4EAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210303062633epcms2p252227acd30ad15c1ca821d7e3f547b9e
References: <f06e9ef0412f14477099cf4b92b5dfde@codeaurora.org>
        <0eb7909278e596c3777e533c09e0f12e@codeaurora.org>
        <aef00e5c83ef9c73644711b4d0bb6e51@codeaurora.org>
        <20210303062633epcms2p252227acd30ad15c1ca821d7e3f547b9e@epcms2p2>
        <20210303062829epcms2p678450953f611c340a2b8e88b5542fe73@epcms2p6>
        <20210312014822epcms2p392a87c6902c21d77c289b0356a598fa4@epcms2p3>
        <20210312071742epcms2p3df88397b5d0b5ea2d09162ee826ca9e8@epcms2p3>
        <CGME20210303062633epcms2p252227acd30ad15c1ca821d7e3f547b9e@epcms2p5>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

>>>>> > This is a patch for managing L2P map in HPB module.
>>>>> >
>>>>> > The HPB divides logical addresses into several regions. A region
>>>>> > consists
>>>>> > of several sub-regions. The sub-region is a basic unit where L2P
>>>>> > mapping is
>>>>> > managed. The driver loads L2P mapping data of each sub-region. The
>>>>> > loaded
>>>>> > sub-region is called active-state. The HPB driver unloads L2P mapping
>>>>> > data
>>>>> > as region unit. The unloaded region is called inactive-state.
>>>>> >
>>>>> > Sub-region/region candidates to be loaded and unloaded are delivered
>>>>> > from
>>>>> > the UFS device. The UFS device delivers the recommended active
>>>>> > sub-region
>>>>> > and inactivate region to the driver using sensedata.
>>>>> > The HPB module performs L2P mapping management on the host through the
>>>>> > delivered information.
>>>>> >
>>>>> > A pinned region is a pre-set regions on the UFS device that is always
>>>>> > activate-state.
>>>>> >
>>>>> > The data structure for map data request and L2P map uses mempool API,
>>>>> > minimizing allocation overhead while avoiding static allocation.
>>>>> >
>>>>> > The mininum size of the memory pool used in the HPB is implemented
>>>>> > as a module parameter, so that it can be configurable by the user.
>>>>> >
>>>>> > To gurantee a minimum memory pool size of 4MB:
>>>>> > ufshpb_host_map_kbytes=4096
>>>>> >
>>>>> > The map_work manages active/inactive by 2 "to-do" lists.
>>>>> > Each hpb lun maintains 2 "to-do" lists:
>>>>> >   hpb->lh_inact_rgn - regions to be inactivated, and
>>>>> >   hpb->lh_act_srgn - subregions to be activated
>>>>> > Those lists are maintained on IO completion.
>>>>> >
>>>>> > Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>>>>> > Reviewed-by: Can Guo <cang@codeaurora.org>
>>>>> > Acked-by: Avri Altman <Avri.Altman@wdc.com>
>>>>> > Tested-by: Bean Huo <beanhuo@micron.com>
>>>>> > Signed-off-by: Daejun Park <daejun7.park@samsung.com>
>>>>> > ---
>>>>> >  drivers/scsi/ufs/ufs.h    |   36 ++
>>>>> >  drivers/scsi/ufs/ufshcd.c |    4 +
>>>>> >  drivers/scsi/ufs/ufshpb.c | 1091 ++++++++++++++++++++++++++++++++++++-
>>>>> >  drivers/scsi/ufs/ufshpb.h |   65 +++
>>>>> >  4 files changed, 1181 insertions(+), 15 deletions(-)
>>>>> >
>>>>> > diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
>>>>> > index 65563635e20e..957763db1006 100644
>>>>> > --- a/drivers/scsi/ufs/ufs.h
>>>>> > +++ b/drivers/scsi/ufs/ufs.h
>>>>> > @@ -472,6 +472,41 @@ struct utp_cmd_rsp {
>>>>> >          u8 sense_data[UFS_SENSE_SIZE];
>>>>> >  };
>>>>> >
>>>>> > +struct ufshpb_active_field {
>>>>> > +        __be16 active_rgn;
>>>>> > +        __be16 active_srgn;
>>>>> > +};
>>>>> > +#define HPB_ACT_FIELD_SIZE 4
>>>>> > +
>>>>> > +/**
>>>>> > + * struct utp_hpb_rsp - Response UPIU structure
>>>>> > + * @residual_transfer_count: Residual transfer count DW-3
>>>>> > + * @reserved1: Reserved double words DW-4 to DW-7
>>>>> > + * @sense_data_len: Sense data length DW-8 U16
>>>>> > + * @desc_type: Descriptor type of sense data
>>>>> > + * @additional_len: Additional length of sense data
>>>>> > + * @hpb_op: HPB operation type
>>>>> > + * @lun: LUN of response UPIU
>>>>> > + * @active_rgn_cnt: Active region count
>>>>> > + * @inactive_rgn_cnt: Inactive region count
>>>>> > + * @hpb_active_field: Recommended to read HPB region and subregion
>>>>> > + * @hpb_inactive_field: To be inactivated HPB region and subregion
>>>>> > + */
>>>>> > +struct utp_hpb_rsp {
>>>>> > +        __be32 residual_transfer_count;
>>>>> > +        __be32 reserved1[4];
>>>>> > +        __be16 sense_data_len;
>>>>> > +        u8 desc_type;
>>>>> > +        u8 additional_len;
>>>>> > +        u8 hpb_op;
>>>>> > +        u8 lun;
>>>>> > +        u8 active_rgn_cnt;
>>>>> > +        u8 inactive_rgn_cnt;
>>>>> > +        struct ufshpb_active_field hpb_active_field[2];
>>>>> > +        __be16 hpb_inactive_field[2];
>>>>> > +};
>>>>> > +#define UTP_HPB_RSP_SIZE 40
>>>>> > +
>>>>> >  /**
>>>>> >   * struct utp_upiu_rsp - general upiu response structure
>>>>> >   * @header: UPIU header structure DW-0 to DW-2
>>>>> > @@ -482,6 +517,7 @@ struct utp_upiu_rsp {
>>>>> >          struct utp_upiu_header header;
>>>>> >          union {
>>>>> >                  struct utp_cmd_rsp sr;
>>>>> > +                struct utp_hpb_rsp hr;
>>>>> >                  struct utp_upiu_query qr;
>>>>> >          };
>>>>> >  };
>>>>> > diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>>>>> > index 49b3d5d24fa6..5852ff44c3cc 100644
>>>>> > --- a/drivers/scsi/ufs/ufshcd.c
>>>>> > +++ b/drivers/scsi/ufs/ufshcd.c
>>>>> > @@ -5021,6 +5021,9 @@ ufshcd_transfer_rsp_status(struct ufs_hba *hba,
>>>>> > struct ufshcd_lrb *lrbp)
>>>>> >                                   */
>>>>> >                                  pm_runtime_get_noresume(hba->dev);
>>>>> >                          }
>>>>> > +
>>>>> > +                        if (scsi_status == SAM_STAT_GOOD)
>>>>> > +                                ufshpb_rsp_upiu(hba, lrbp);
>>>>> >                          break;
>>>>> >                  case UPIU_TRANSACTION_REJECT_UPIU:
>>>>> >                          /* TODO: handle Reject UPIU Response */
>>>>> > @@ -9221,6 +9224,7 @@ EXPORT_SYMBOL(ufshcd_shutdown);
>>>>> >  void ufshcd_remove(struct ufs_hba *hba)
>>>>> >  {
>>>>> >          ufs_bsg_remove(hba);
>>>>> > +        ufshpb_remove(hba);
>>>>> >          ufs_sysfs_remove_nodes(hba->dev);
>>>>> >          blk_cleanup_queue(hba->tmf_queue);
>>>>> >          blk_mq_free_tag_set(&hba->tmf_tag_set);
>>>>> > diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
>>>>> > index 1a72f6541510..8abadb0e010a 100644
>>>>> > --- a/drivers/scsi/ufs/ufshpb.c
>>>>> > +++ b/drivers/scsi/ufs/ufshpb.c
>>>>> > @@ -16,6 +16,16 @@
>>>>> >  #include "ufshpb.h"
>>>>> >  #include "../sd.h"
>>>>> >
>>>>> > +/* memory management */
>>>>> > +static struct kmem_cache *ufshpb_mctx_cache;
>>>>> > +static mempool_t *ufshpb_mctx_pool;
>>>>> > +static mempool_t *ufshpb_page_pool;
>>>>> > +/* A cache size of 2MB can cache ppn in the 1GB range. */
>>>>> > +static unsigned int ufshpb_host_map_kbytes = 2048;
>>>>> > +static int tot_active_srgn_pages;
>>>>> > +
>>>>> > +static struct workqueue_struct *ufshpb_wq;
>>>>> > +
>>>>> >  bool ufshpb_is_allowed(struct ufs_hba *hba)
>>>>> >  {
>>>>> >          return !(hba->ufshpb_dev.hpb_disabled);
>>>>> > @@ -36,14 +46,892 @@ static void ufshpb_set_state(struct ufshpb_lu
>>>>> > *hpb, int state)
>>>>> >          atomic_set(&hpb->hpb_state, state);
>>>>> >  }
>>>>> >
>>>>> > +static bool ufshpb_is_general_lun(int lun)
>>>>> > +{
>>>>> > +        return lun < UFS_UPIU_MAX_UNIT_NUM_ID;
>>>>> > +}
>>>>> > +
>>>>> > +static bool
>>>>> > +ufshpb_is_pinned_region(struct ufshpb_lu *hpb, int rgn_idx)
>>>>> > +{
>>>>> > +        if (hpb->lu_pinned_end != PINNED_NOT_SET &&
>>>>> > +            rgn_idx >= hpb->lu_pinned_start &&
>>>>> > +            rgn_idx <= hpb->lu_pinned_end)
>>>>> > +                return true;
>>>>> > +
>>>>> > +        return false;
>>>>> > +}
>>>>> > +
>>>>> > +static void ufshpb_kick_map_work(struct ufshpb_lu *hpb)
>>>>> > +{
>>>>> > +        bool ret = false;
>>>>> > +        unsigned long flags;
>>>>> > +
>>>>> > +        if (ufshpb_get_state(hpb) != HPB_PRESENT)
>>>>> > +                return;
>>>>> > +
>>>>> > +        spin_lock_irqsave(&hpb->rsp_list_lock, flags);
>>>>> > +        if (!list_empty(&hpb->lh_inact_rgn) ||
>>>>> > !list_empty(&hpb->lh_act_srgn))
>>>>> > +                ret = true;
>>>>> > +        spin_unlock_irqrestore(&hpb->rsp_list_lock, flags);
>>>>> > +
>>>>> > +        if (ret)
>>>>> > +                queue_work(ufshpb_wq, &hpb->map_work);
>>>>> > +}
>>>>> > +
>>>>> > +static bool ufshpb_is_hpb_rsp_valid(struct ufs_hba *hba,
>>>>> > +                                         struct ufshcd_lrb *lrbp,
>>>>> > +                                         struct utp_hpb_rsp *rsp_field)
>>>>> > +{
>>>>> > +        /* Check HPB_UPDATE_ALERT */
>>>>> > +        if (!(lrbp->ucd_rsp_ptr->header.dword_2 &
>>>>> > +              UPIU_HEADER_DWORD(0, 2, 0, 0)))
>>>>> > +                return false;
>>>>> > +
>>>>> > +        if (be16_to_cpu(rsp_field->sense_data_len) != DEV_SENSE_SEG_LEN ||
>>>>> > +            rsp_field->desc_type != DEV_DES_TYPE ||
>>>>> > +            rsp_field->additional_len != DEV_ADDITIONAL_LEN ||
>>>>> > +            rsp_field->active_rgn_cnt > MAX_ACTIVE_NUM ||
>>>>> > +            rsp_field->inactive_rgn_cnt > MAX_INACTIVE_NUM ||
>>>>> > +            rsp_field->hpb_op == HPB_RSP_NONE ||
>>>>> > +            (rsp_field->hpb_op == HPB_RSP_REQ_REGION_UPDATE &&
>>>>> > +             !rsp_field->active_rgn_cnt && !rsp_field->inactive_rgn_cnt))
>>>>> > +                return false;
>>>>> > +
>>>>> > +        if (!ufshpb_is_general_lun(rsp_field->lun)) {
>>>>> > +                dev_warn(hba->dev, "ufshpb: lun(%d) not supported\n",
>>>>> > +                         lrbp->lun);
>>>>> > +                return false;
>>>>> > +        }
>>>>> > +
>>>>> > +        return true;
>>>>> > +}
>>>>> > +
>>>>> > +static struct ufshpb_req *ufshpb_get_map_req(struct ufshpb_lu *hpb,
>>>>> > +                                             struct ufshpb_subregion *srgn)
>>>>> > +{
>>>>> > +        struct ufshpb_req *map_req;
>>>>> > +        struct request *req;
>>>>> > +        struct bio *bio;
>>>>> > +        int retries = HPB_MAP_REQ_RETRIES;
>>>>> > +
>>>>> > +        map_req = kmem_cache_alloc(hpb->map_req_cache, GFP_KERNEL);
>>>>> > +        if (!map_req)
>>>>> > +                return NULL;
>>>>> > +
>>>>> > +retry:
>>>>> > +        req = blk_get_request(hpb->sdev_ufs_lu->request_queue,
>>>>> > +                              REQ_OP_SCSI_IN, BLK_MQ_REQ_NOWAIT);
>>>>> > +
>>>>> > +        if ((PTR_ERR(req) == -EWOULDBLOCK) && (--retries > 0)) {
>>>>> > +                usleep_range(3000, 3100);
>>>>> > +                goto retry;
>>>>> > +        }
>>>>> > +
>>>>> > +        if (IS_ERR(req))
>>>>> > +                goto free_map_req;
>>>>> > +
>>>>> > +        bio = bio_alloc(GFP_KERNEL, hpb->pages_per_srgn);
>>>>> > +        if (!bio) {
>>>>> > +                blk_put_request(req);
>>>>> > +                goto free_map_req;
>>>>> > +        }
>>>>> > +
>>>>> > +        map_req->hpb = hpb;
>>>>> > +        map_req->req = req;
>>>>> > +        map_req->bio = bio;
>>>>> > +
>>>>> > +        map_req->rgn_idx = srgn->rgn_idx;
>>>>> > +        map_req->srgn_idx = srgn->srgn_idx;
>>>>> > +        map_req->mctx = srgn->mctx;
>>>>> > +
>>>>> > +        return map_req;
>>>>> > +
>>>>> > +free_map_req:
>>>>> > +        kmem_cache_free(hpb->map_req_cache, map_req);
>>>>> > +        return NULL;
>>>>> > +}
>>>>> > +
>>>>> > +static void ufshpb_put_map_req(struct ufshpb_lu *hpb,
>>>>> > +                                      struct ufshpb_req *map_req)
>>>>> > +{
>>>>> > +        bio_put(map_req->bio);
>>>>> > +        blk_put_request(map_req->req);
>>>>> > +        kmem_cache_free(hpb->map_req_cache, map_req);
>>>>> > +}
>>>>> > +
>>>>> > +static int ufshpb_clear_dirty_bitmap(struct ufshpb_lu *hpb,
>>>>> > +                                     struct ufshpb_subregion *srgn)
>>>>> > +{
>>>>> > +        u32 num_entries = hpb->entries_per_srgn;
>>>>> > +
>>>>> > +        if (!srgn->mctx) {
>>>>> > +                dev_err(&hpb->sdev_ufs_lu->sdev_dev,
>>>>> > +                        "no mctx in region %d subregion %d.\n",
>>>>> > +                        srgn->rgn_idx, srgn->srgn_idx);
>>>>> > +                return -1;
>>>>> > +        }
>>>>> > +
>>>>> > +        if (unlikely(srgn->is_last))
>>>>> > +                num_entries = hpb->last_srgn_entries;
>>>>> > +
>>>>> > +        bitmap_zero(srgn->mctx->ppn_dirty, num_entries);
>>>>> > +        return 0;
>>>>> > +}
>>>>> > +
>>>>> > +static void ufshpb_update_active_info(struct ufshpb_lu *hpb, int
>>>>> > rgn_idx,
>>>>> > +                                      int srgn_idx)
>>>>> > +{
>>>>> > +        struct ufshpb_region *rgn;
>>>>> > +        struct ufshpb_subregion *srgn;
>>>>> > +
>>>>> > +        rgn = hpb->rgn_tbl + rgn_idx;
>>>>> > +        srgn = rgn->srgn_tbl + srgn_idx;
>>>>> > +
>>>>> > +        list_del_init(&rgn->list_inact_rgn);
>>>>> > +
>>>>> > +        if (list_empty(&srgn->list_act_srgn))
>>>>> > +                list_add_tail(&srgn->list_act_srgn, &hpb->lh_act_srgn);
>>>>> > +}
>>>>> > +
>>>>> > +static void ufshpb_update_inactive_info(struct ufshpb_lu *hpb, int
>>>>> > rgn_idx)
>>>>> > +{
>>>>> > +        struct ufshpb_region *rgn;
>>>>> > +        struct ufshpb_subregion *srgn;
>>>>> > +        int srgn_idx;
>>>>> > +
>>>>> > +        rgn = hpb->rgn_tbl + rgn_idx;
>>>>> > +
>>>>> > +        for_each_sub_region(rgn, srgn_idx, srgn)
>>>>> > +                list_del_init(&srgn->list_act_srgn);
>>>>> > +
>>>>> > +        if (list_empty(&rgn->list_inact_rgn))
>>>>> > +                list_add_tail(&rgn->list_inact_rgn, &hpb->lh_inact_rgn);
>>>>> > +}
>>>>> > +
>>>>> > +static void ufshpb_activate_subregion(struct ufshpb_lu *hpb,
>>>>> > +                                      struct ufshpb_subregion *srgn)
>>>>> > +{
>>>>> > +        struct ufshpb_region *rgn;
>>>>> > +
>>>>> > +        /*
>>>>> > +         * If there is no mctx in subregion
>>>>> > +         * after I/O progress for HPB_READ_BUFFER, the region to which the
>>>>> > +         * subregion belongs was evicted.
>>>>> > +         * Make sure the region must not evict in I/O progress
>>>>> > +         */
>>>>> > +        if (!srgn->mctx) {
>>>>> > +                dev_err(&hpb->sdev_ufs_lu->sdev_dev,
>>>>> > +                        "no mctx in region %d subregion %d.\n",
>>>>> > +                        srgn->rgn_idx, srgn->srgn_idx);
>>>>> > +                srgn->srgn_state = HPB_SRGN_INVALID;
>>>>> > +                return;
>>>>> > +        }
>>>>> > +
>>>>> > +        rgn = hpb->rgn_tbl + srgn->rgn_idx;
>>>>> > +
>>>>> > +        if (unlikely(rgn->rgn_state == HPB_RGN_INACTIVE)) {
>>>>> > +                dev_err(&hpb->sdev_ufs_lu->sdev_dev,
>>>>> > +                        "region %d subregion %d evicted\n",
>>>>> > +                        srgn->rgn_idx, srgn->srgn_idx);
>>>>> > +                srgn->srgn_state = HPB_SRGN_INVALID;
>>>>> > +                return;
>>>>> > +        }
>>>>> > +        srgn->srgn_state = HPB_SRGN_VALID;
>>>>> > +}
>>>>> > +
>>>>> > +static void ufshpb_map_req_compl_fn(struct request *req, blk_status_t
>>>>> > error)
>>>>> > +{
>>>>> > +        struct ufshpb_req *map_req = (struct ufshpb_req *) req->end_io_data;
>>>>> > +        struct ufshpb_lu *hpb = map_req->hpb;
>>>>> > +        struct ufshpb_subregion *srgn;
>>>>> > +        unsigned long flags;
>>>>> > +
>>>>> > +        srgn = hpb->rgn_tbl[map_req->rgn_idx].srgn_tbl +
>>>>> > +                map_req->srgn_idx;
>>>>> > +
>>>>> > +        ufshpb_clear_dirty_bitmap(hpb, srgn);
>>>>> > +        spin_lock_irqsave(&hpb->rgn_state_lock, flags);
>>>>> > +        ufshpb_activate_subregion(hpb, srgn);
>>>>> > +        spin_unlock_irqrestore(&hpb->rgn_state_lock, flags);
>>>>> > +
>>>>> > +        ufshpb_put_map_req(map_req->hpb, map_req);
>>>>> > +}
>>>>> > +
>>>>> > +static void ufshpb_set_read_buf_cmd(unsigned char *cdb, int rgn_idx,
>>>>> > +                                    int srgn_idx, int srgn_mem_size)
>>>>> > +{
>>>>> > +        cdb[0] = UFSHPB_READ_BUFFER;
>>>>> > +        cdb[1] = UFSHPB_READ_BUFFER_ID;
>>>>> > +
>>>>> > +        put_unaligned_be16(rgn_idx, &cdb[2]);
>>>>> > +        put_unaligned_be16(srgn_idx, &cdb[4]);
>>>>> > +        put_unaligned_be24(srgn_mem_size, &cdb[6]);
>>>>> > +
>>>>> > +        cdb[9] = 0x00;
>>>>> > +}
>>>>> > +
>>>>> > +static int ufshpb_execute_map_req(struct ufshpb_lu *hpb,
>>>>> > +                                  struct ufshpb_req *map_req, bool last)
>>>>> > +{
>>>>> > +        struct request_queue *q;
>>>>> > +        struct request *req;
>>>>> > +        struct scsi_request *rq;
>>>>> > +        int mem_size = hpb->srgn_mem_size;
>>>>> > +        int ret = 0;
>>>>> > +        int i;
>>>>> > +
>>>>> > +        q = hpb->sdev_ufs_lu->request_queue;
>>>>> > +        for (i = 0; i < hpb->pages_per_srgn; i++) {
>>>>> > +                ret = bio_add_pc_page(q, map_req->bio, map_req->mctx->m_page[i],
>>>>> > +                                      PAGE_SIZE, 0);
>>>>> > +                if (ret != PAGE_SIZE) {
>>>>> > +                        dev_err(&hpb->sdev_ufs_lu->sdev_dev,
>>>>> > +                                   "bio_add_pc_page fail %d - %d\n",
>>>>> > +                                   map_req->rgn_idx, map_req->srgn_idx);
>>>>> > +                        return ret;
>>>>> > +                }
>>>>> > +        }
>>>>> > +
>>>>> > +        req = map_req->req;
>>>>> > +
>>>>> > +        blk_rq_append_bio(req, &map_req->bio);
>>>>> > +
>>>>> > +        req->end_io_data = map_req;
>>>>> > +
>>>>> > +        rq = scsi_req(req);
>>>>> > +
>>>>> > +        if (unlikely(last))
>>>>> > +                mem_size = hpb->last_srgn_entries * HPB_ENTRY_SIZE;
>>>>> > +
>>>>> > +        ufshpb_set_read_buf_cmd(rq->cmd, map_req->rgn_idx,
>>>>> > +                                map_req->srgn_idx, mem_size);
>>>>> > +        rq->cmd_len = HPB_READ_BUFFER_CMD_LENGTH;
>>>>> > +
>>>>> > +        blk_execute_rq_nowait(q, NULL, req, 1, ufshpb_map_req_compl_fn);
>>>>> > +
>>>>> > +        hpb->stats.map_req_cnt++;
>>>>> > +        return 0;
>>>>> > +}
>>>>> > +
>>>>> > +static struct ufshpb_map_ctx *ufshpb_get_map_ctx(struct ufshpb_lu
>>>>> > *hpb,
>>>>> > +                                                 bool last)
>>>>> > +{
>>>>> > +        struct ufshpb_map_ctx *mctx;
>>>>> > +        u32 num_entries = hpb->entries_per_srgn;
>>>>> > +        int i, j;
>>>>> > +
>>>>> > +        mctx = mempool_alloc(ufshpb_mctx_pool, GFP_KERNEL);
>>>>> > +        if (!mctx)
>>>>> > +                return NULL;
>>>>> > +
>>>>> > +        mctx->m_page = kmem_cache_alloc(hpb->m_page_cache, GFP_KERNEL);
>>>>> > +        if (!mctx->m_page)
>>>>> > +                goto release_mctx;
>>>>> > +
>>>>> > +        if (unlikely(last))
>>>>> > +                num_entries = hpb->last_srgn_entries;
>>>>> > +
>>>>> > +        mctx->ppn_dirty = bitmap_zalloc(num_entries, GFP_KERNEL);
>>>>> > +        if (!mctx->ppn_dirty)
>>>>> > +                goto release_m_page;
>>>>> > +
>>>>> > +        for (i = 0; i < hpb->pages_per_srgn; i++) {
>>>>> > +                mctx->m_page[i] = mempool_alloc(ufshpb_page_pool, GFP_KERNEL);
>>>>> > +                if (!mctx->m_page[i]) {
>>>>> > +                        for (j = 0; j < i; j++)
>>>>> > +                                mempool_free(mctx->m_page[j], ufshpb_page_pool);
>>>>> > +                        goto release_ppn_dirty;
>>>>> > +                }
>>>>> > +                clear_page(page_address(mctx->m_page[i]));
>>>>> > +        }
>>>>> > +
>>>>> > +        return mctx;
>>>>> > +
>>>>> > +release_ppn_dirty:
>>>>> > +        bitmap_free(mctx->ppn_dirty);
>>>>> > +release_m_page:
>>>>> > +        kmem_cache_free(hpb->m_page_cache, mctx->m_page);
>>>>> > +release_mctx:
>>>>> > +        mempool_free(mctx, ufshpb_mctx_pool);
>>>>> > +        return NULL;
>>>>> > +}
>>>>> > +
>>>>> > +static void ufshpb_put_map_ctx(struct ufshpb_lu *hpb,
>>>>> > +                               struct ufshpb_map_ctx *mctx)
>>>>> > +{
>>>>> > +        int i;
>>>>> > +
>>>>> > +        for (i = 0; i < hpb->pages_per_srgn; i++)
>>>>> > +                mempool_free(mctx->m_page[i], ufshpb_page_pool);
>>>>> > +
>>>>> > +        bitmap_free(mctx->ppn_dirty);
>>>>> > +        kmem_cache_free(hpb->m_page_cache, mctx->m_page);
>>>>> > +        mempool_free(mctx, ufshpb_mctx_pool);
>>>>> > +}
>>>>> > +
>>>>> > +static int ufshpb_check_srgns_issue_state(struct ufshpb_lu *hpb,
>>>>> > +                                          struct ufshpb_region *rgn)
>>>>> > +{
>>>>> > +        struct ufshpb_subregion *srgn;
>>>>> > +        int srgn_idx;
>>>>> > +
>>>>> > +        for_each_sub_region(rgn, srgn_idx, srgn)
>>>>> > +                if (srgn->srgn_state == HPB_SRGN_ISSUED)
>>>>> > +                        return -EPERM;
>>>>> > +
>>>>> > +        return 0;
>>>>> > +}
>>>>> > +
>>>>> > +static void ufshpb_add_lru_info(struct victim_select_info *lru_info,
>>>>> > +                                struct ufshpb_region *rgn)
>>>>> > +{
>>>>> > +        rgn->rgn_state = HPB_RGN_ACTIVE;
>>>>> > +        list_add_tail(&rgn->list_lru_rgn, &lru_info->lh_lru_rgn);
>>>>> > +        atomic_inc(&lru_info->active_cnt);
>>>>> > +}
>>>>> > +
>>>>> > +static void ufshpb_hit_lru_info(struct victim_select_info *lru_info,
>>>>> > +                                struct ufshpb_region *rgn)
>>>>> > +{
>>>>> > +        list_move_tail(&rgn->list_lru_rgn, &lru_info->lh_lru_rgn);
>>>>> > +}
>>>>> > +
>>>>> > +static struct ufshpb_region *ufshpb_victim_lru_info(struct ufshpb_lu
>>>>> > *hpb)
>>>>> > +{
>>>>> > +        struct victim_select_info *lru_info = &hpb->lru_info;
>>>>> > +        struct ufshpb_region *rgn, *victim_rgn = NULL;
>>>>> > +
>>>>> > +        list_for_each_entry(rgn, &lru_info->lh_lru_rgn, list_lru_rgn) {
>>>>> > +                if (!rgn) {
>>>>> > +                        dev_err(&hpb->sdev_ufs_lu->sdev_dev,
>>>>> > +                                "%s: no region allocated\n",
>>>>> > +                                __func__);
>>>>> > +                        return NULL;
>>>>> > +                }
>>>>> > +                if (ufshpb_check_srgns_issue_state(hpb, rgn))
>>>>> > +                        continue;
>>>>> > +
>>>>> > +                victim_rgn = rgn;
>>>>> > +                break;
>>>>> > +        }
>>>>> > +
>>>>> > +        return victim_rgn;
>>>>> > +}
>>>>> > +
>>>>> > +static void ufshpb_cleanup_lru_info(struct victim_select_info
>>>>> > *lru_info,
>>>>> > +                                    struct ufshpb_region *rgn)
>>>>> > +{
>>>>> > +        list_del_init(&rgn->list_lru_rgn);
>>>>> > +        rgn->rgn_state = HPB_RGN_INACTIVE;
>>>>> > +        atomic_dec(&lru_info->active_cnt);
>>>>> > +}
>>>>> > +
>>>>> > +static void ufshpb_purge_active_subregion(struct ufshpb_lu *hpb,
>>>>> > +                                          struct ufshpb_subregion *srgn)
>>>>> > +{
>>>>> > +        if (srgn->srgn_state != HPB_SRGN_UNUSED) {
>>>>> > +                ufshpb_put_map_ctx(hpb, srgn->mctx);
>>>>> > +                srgn->srgn_state = HPB_SRGN_UNUSED;
>>>>> > +                srgn->mctx = NULL;
>>>>> > +        }
>>>>> > +}
>>>>> > +
>>>>> > +static void __ufshpb_evict_region(struct ufshpb_lu *hpb,
>>>>> > +                                  struct ufshpb_region *rgn)
>>>>> > +{
>>>>> > +        struct victim_select_info *lru_info;
>>>>> > +        struct ufshpb_subregion *srgn;
>>>>> > +        int srgn_idx;
>>>>> > +
>>>>> > +        lru_info = &hpb->lru_info;
>>>>> > +
>>>>> > +        dev_dbg(&hpb->sdev_ufs_lu->sdev_dev, "evict region %d\n",
>>>>> > rgn->rgn_idx);
>>>>> > +
>>>>> > +        ufshpb_cleanup_lru_info(lru_info, rgn);
>>>>> > +
>>>>> > +        for_each_sub_region(rgn, srgn_idx, srgn)
>>>>> > +                ufshpb_purge_active_subregion(hpb, srgn);
>>>>> > +}
>>>>> > +
>>>>> > +static int ufshpb_evict_region(struct ufshpb_lu *hpb, struct
>>>>> > ufshpb_region *rgn)
>>>>> > +{
>>>>> > +        unsigned long flags;
>>>>> > +        int ret = 0;
>>>>> > +
>>>>> > +        spin_lock_irqsave(&hpb->rgn_state_lock, flags);
>>>>> > +        if (rgn->rgn_state == HPB_RGN_PINNED) {
>>>>> > +                dev_warn(&hpb->sdev_ufs_lu->sdev_dev,
>>>>> > +                         "pinned region cannot drop-out. region %d\n",
>>>>> > +                         rgn->rgn_idx);
>>>>> > +                goto out;
>>>>> > +        }
>>>>> > +        if (!list_empty(&rgn->list_lru_rgn)) {
>>>>> > +                if (ufshpb_check_srgns_issue_state(hpb, rgn)) {
>>>>> > +                        ret = -EBUSY;
>>>>> > +                        goto out;
>>>>> > +                }
>>>>> > +
>>>>> > +                __ufshpb_evict_region(hpb, rgn);
>>>>> > +        }
>>>>> > +out:
>>>>> > +        spin_unlock_irqrestore(&hpb->rgn_state_lock, flags);
>>>>> > +        return ret;
>>>>> > +}
>>>>> > +
>>>>> > +static int ufshpb_issue_map_req(struct ufshpb_lu *hpb,
>>>>> > +                                struct ufshpb_region *rgn,
>>>>> > +                                struct ufshpb_subregion *srgn)
>>>>> > +{
>>>>> > +        struct ufshpb_req *map_req;
>>>>> > +        unsigned long flags;
>>>>> > +        int ret;
>>>>> > +        int err = -EAGAIN;
>>>>> > +        bool alloc_required = false;
>>>>> > +        enum HPB_SRGN_STATE state = HPB_SRGN_INVALID;
>>>>> > +
>>>>> > +        spin_lock_irqsave(&hpb->rgn_state_lock, flags);
>>>>> > +
>>>>> > +        if (ufshpb_get_state(hpb) != HPB_PRESENT) {
>>>>> > +                dev_notice(&hpb->sdev_ufs_lu->sdev_dev,
>>>>> > +                           "%s: ufshpb state is not PRESENT\n", __func__);
>>>>> > +                goto unlock_out;
>>>>> > +        }
>>>>> > +
>>>>> > +        if ((rgn->rgn_state == HPB_RGN_INACTIVE) &&
>>>>> > +            (srgn->srgn_state == HPB_SRGN_INVALID)) {
>>>>> > +                err = 0;
>>>>> > +                goto unlock_out;
>>>>> > +        }
>>>>> > +
>>>>> > +        if (srgn->srgn_state == HPB_SRGN_UNUSED)
>>>>> > +                alloc_required = true;
>>>>> > +
>>>>> > +        /*
>>>>> > +         * If the subregion is already ISSUED state,
>>>>> > +         * a specific event (e.g., GC or wear-leveling, etc.) occurs in
>>>>> > +         * the device and HPB response for map loading is received.
>>>>> > +         * In this case, after finishing the HPB_READ_BUFFER,
>>>>> > +         * the next HPB_READ_BUFFER is performed again to obtain the latest
>>>>> > +         * map data.
>>>>> > +         */
>>>>> > +        if (srgn->srgn_state == HPB_SRGN_ISSUED)
>>>>> > +                goto unlock_out;
>>>>> > +
>>>>> > +        srgn->srgn_state = HPB_SRGN_ISSUED;
>>>>> > +        spin_unlock_irqrestore(&hpb->rgn_state_lock, flags);
>>>>> > +
>>>>> > +        if (alloc_required) {
>>>>> > +                if (srgn->mctx) {
>>>>> 
>>>>> Can this really happen?
>>>>> 
>>>>> alloc_required is true if srgn->srgn_state == HPB_SRGN_UNUSED.
>>>>> ufshpb_put_map_ctx() is called and srgn->srgn_state is given
>>>>> HPB_SRGN_UNUSED together in ufshpb_purge_active_subregion().
>>>>> Do I miss anything?
>>>> 
>>>> It is not normal case, but it is for preventing memory leak on 
>>>> abnormal
>>>> case.
>>>> 
>>>> Thanks,
>>>> Daejun
>>> 
>>> Abnormal how? Could you please give an example?
>> 
>> It is kind of additional memory leak protection. Do you think it is 
>> unnecessary?
> 
>If this can never happen in this code base, then yes it is unnecessary,
>since it is dead code. It seems to me like a debug print left there in
>early development stage of this change. I am just curious about what
>memory leak can happen here. If you are not confident, then please leave 
>it.

OK, I will delete it on next patch.

Thanks,
Daejun


>Thanks,
>Can Guo.
> 
>> 
>> Thanks,
>> Daejun
> 
> 
>  
