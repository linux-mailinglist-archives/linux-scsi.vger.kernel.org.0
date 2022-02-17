Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F10E4BAA10
	for <lists+linux-scsi@lfdr.de>; Thu, 17 Feb 2022 20:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbiBQTpd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 17 Feb 2022 14:45:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiBQTpc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 17 Feb 2022 14:45:32 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D0741FB2
        for <linux-scsi@vger.kernel.org>; Thu, 17 Feb 2022 11:45:16 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id gb39so9780564ejc.1
        for <linux-scsi@vger.kernel.org>; Thu, 17 Feb 2022 11:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7/AHIwx6A2VveNK1cyl/3QLbc/1aqiIf2mfR+/VTeEw=;
        b=d3einRng/xAvEDJYzH0bDxVA72QeROE3jZiBb3+/iQTufOqEiaF4d+GPXyt9MsPgt3
         vCmZ3uE2DHd6vzo2cMIRRFGHR6O62enn8p/N0QlLvBOfAoAHjGS7eBfoIUdJv6mOOf5Y
         ObpDPiXLlNWmFX6+WF0noL6ZzKtou22oEefYljETUvvz24JD7UTqABUwIu/274/eFipc
         D1cuyw29l5qHFJuOZUUJfxizPSCpYo8jfVmUkgBuKXiaIJSQwaICseO2ihOqHfkvNlae
         lALECGRwNTy9F02w0vxbvFkl7jN11Pf8lmX+wYl0iRYDUWkshUHcpmurLSIjKleqi+mr
         DqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/AHIwx6A2VveNK1cyl/3QLbc/1aqiIf2mfR+/VTeEw=;
        b=PBkH1rjycXIjAPeCjb9tD/OS2E7ZuqVpZsEniUgaCojRun/9rzHraxYOVNfJGXmyin
         BfFSQUR1l45iCjqYwNifoomBwQ6CbiDmEaPCBmM7mTuHWxcUFwk1VcWhGzbf5d9OBuh0
         vxGX06vMbCWMxk/A3mgtlSbq4Ky146W+S1Wd0nXwHJpNwX/CQaewiR5bK7p7zrrK/1PL
         ZSDSlRY/c4eVjEbSmGEZPXUQ9yQ25gu+VBpYlFViYwzGNMpHepFP9qZrwdj3w3mDG0MA
         ic/0F6Uj+rSnbba2P8xURFBGInWs03vXzXYvRATYk+RFlW2E1tRbzaRIc7nlJxKziKi3
         vjuw==
X-Gm-Message-State: AOAM533KfaAzA0CNegyjG6dbpwfwEo9Q5JtYVU5PATyl/g5bM7B9nxWs
        RWa4guY1qCY7QqSyCkxNbA8u57xn/D4glmw3HzBXpndpBEZtOQ==
X-Google-Smtp-Source: ABdhPJwLAj+q807ZoSi4DjRkULplm9pnNR30Ee7lmFo08GsbBjXaezOqYSosN1QjsqQYDqGMF+V6T6HbZZV9P2XeasQ=
X-Received: by 2002:a17:906:b201:b0:6b5:58c8:e43c with SMTP id
 p1-20020a170906b20100b006b558c8e43cmr3471265ejz.441.1645127114434; Thu, 17
 Feb 2022 11:45:14 -0800 (PST)
MIME-Version: 1.0
References: <20220217132956.484818-1-damien.lemoal@opensource.wdc.com> <20220217132956.484818-27-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220217132956.484818-27-damien.lemoal@opensource.wdc.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 17 Feb 2022 20:45:03 +0100
Message-ID: <CAMGffEmvrLKdaV9r3UAH8TUHDbUR+4t3M+zXRuCVeYt7jZXYfA@mail.gmail.com>
Subject: Re: [PATCH v4 26/31] scsi: pm8001: Introduce ccb alloc/free helpers
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        John Garry <john.garry@huawei.com>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        Jason Yan <yanaijie@huawei.com>,
        Luo Jiaxing <luojiaxing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Feb 17, 2022 at 2:30 PM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> Introduce the pm8001_ccb_alloc() and pm8001_ccb_free() helpers to
> replace the typical code patterns:
>
>         res = pm8001_tag_alloc(pm8001_ha, &ccb_tag);
>         if (res)
>                 ...
>         ccb = &pm8001_ha->ccb_info[ccb_tag];
>         ccb->device = pm8001_ha_dev;
>         ccb->ccb_tag = ccb_tag;
>         ccb->task = task;
>         ccb->n_elem = 0;
>
> and
>
>         ccb->task = NULL;
>         ccb->ccb_tag = PM8001_INVALID_TAG;
>         pm8001_tag_free(pm8001_ha, tag);
>
> With the simpler function calls:
>
>         ccb = pm8001_ccb_alloc(pm8001_ha, pm8001_ha_dev, task);
>         if (!ccb)
>                 ...
>
> and
>
>         pm8001_ccb_free(pm8001_ha, ccb);
>
> The pm8001_ccb_alloc() helper ensures that all fields of the ccb info
> structure for the newly allocated tag are all initialized, except the
> buf_prd field. The pm8001_ccb_free() helper clears the initialized
> fields and the ccb tag to ensure that iteration over the adapter
> ccb_info array detects ccbs that are in use.
>
> All call site of the pm8001_tag_alloc() function that use a ccb info
> associated with an allocated tag are converted to use the new helpers.
>
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/scsi/pm8001/pm8001_hwi.c | 180 +++++++++++++------------------
>  drivers/scsi/pm8001/pm8001_sas.c |  46 ++++----
>  drivers/scsi/pm8001/pm8001_sas.h |  47 ++++++++
>  drivers/scsi/pm8001/pm80xx_hwi.c |  64 +++++------
>  4 files changed, 166 insertions(+), 171 deletions(-)
so we saved 5 lines :)
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
>
> diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
> index 41077c84eec9..699fecc09267 100644
> --- a/drivers/scsi/pm8001/pm8001_hwi.c
> +++ b/drivers/scsi/pm8001/pm8001_hwi.c
> @@ -1710,7 +1710,7 @@ void pm8001_work_fn(struct work_struct *work)
>                                         pm8001_dev->dcompletion = NULL;
>                                 }
>                                 complete(pm8001_ha->nvmd_completion);
> -                               pm8001_tag_free(pm8001_ha, ccb->ccb_tag);
> +                               pm8001_ccb_free(pm8001_ha, ccb);
>                         }
>                 }
>                 /* Deregister all the device ids  */
> @@ -1749,8 +1749,6 @@ int pm8001_handle_event(struct pm8001_hba_info *pm8001_ha, void *data,
>  static void pm8001_send_abort_all(struct pm8001_hba_info *pm8001_ha,
>                 struct pm8001_device *pm8001_ha_dev)
>  {
> -       int res;
> -       u32 ccb_tag;
>         struct pm8001_ccb_info *ccb;
>         struct sas_task *task = NULL;
>         struct task_abort_req task_abort;
> @@ -1771,32 +1769,25 @@ static void pm8001_send_abort_all(struct pm8001_hba_info *pm8001_ha,
>
>         task->task_done = pm8001_task_done;
>
> -       res = pm8001_tag_alloc(pm8001_ha, &ccb_tag);
> -       if (res) {
> +       ccb = pm8001_ccb_alloc(pm8001_ha, pm8001_ha_dev, task);
> +       if (!ccb) {
>                 sas_free_task(task);
>                 return;
>         }
>
> -       ccb = &pm8001_ha->ccb_info[ccb_tag];
> -       ccb->device = pm8001_ha_dev;
> -       ccb->ccb_tag = ccb_tag;
> -       ccb->task = task;
> -       ccb->n_elem = 0;
> -
>         circularQ = &pm8001_ha->inbnd_q_tbl[0];
>
>         memset(&task_abort, 0, sizeof(task_abort));
>         task_abort.abort_all = cpu_to_le32(1);
>         task_abort.device_id = cpu_to_le32(pm8001_ha_dev->device_id);
> -       task_abort.tag = cpu_to_le32(ccb_tag);
> +       task_abort.tag = cpu_to_le32(ccb->ccb_tag);
>
>         ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &task_abort,
>                         sizeof(task_abort), 0);
>         if (ret) {
>                 sas_free_task(task);
> -               pm8001_tag_free(pm8001_ha, ccb_tag);
> +               pm8001_ccb_free(pm8001_ha, ccb);
>         }
> -
>  }
>
>  static void pm8001_send_read_log(struct pm8001_hba_info *pm8001_ha,
> @@ -1804,7 +1795,6 @@ static void pm8001_send_read_log(struct pm8001_hba_info *pm8001_ha,
>  {
>         struct sata_start_req sata_cmd;
>         int res;
> -       u32 ccb_tag;
>         struct pm8001_ccb_info *ccb;
>         struct sas_task *task = NULL;
>         struct host_to_dev_fis fis;
> @@ -1820,20 +1810,13 @@ static void pm8001_send_read_log(struct pm8001_hba_info *pm8001_ha,
>         }
>         task->task_done = pm8001_task_done;
>
> -       res = pm8001_tag_alloc(pm8001_ha, &ccb_tag);
> -       if (res) {
> -               sas_free_task(task);
> -               pm8001_dbg(pm8001_ha, FAIL, "cannot allocate tag !!!\n");
> -               return;
> -       }
> -
> -       /* allocate domain device by ourselves as libsas
> -        * is not going to provide any
> -       */
> +       /*
> +        * Allocate domain device by ourselves as libsas is not going to
> +        * provide any.
> +        */
>         dev = kzalloc(sizeof(struct domain_device), GFP_ATOMIC);
>         if (!dev) {
>                 sas_free_task(task);
> -               pm8001_tag_free(pm8001_ha, ccb_tag);
>                 pm8001_dbg(pm8001_ha, FAIL,
>                            "Domain device cannot be allocated\n");
>                 return;
> @@ -1841,11 +1824,13 @@ static void pm8001_send_read_log(struct pm8001_hba_info *pm8001_ha,
>         task->dev = dev;
>         task->dev->lldd_dev = pm8001_ha_dev;
>
> -       ccb = &pm8001_ha->ccb_info[ccb_tag];
> -       ccb->device = pm8001_ha_dev;
> -       ccb->ccb_tag = ccb_tag;
> -       ccb->task = task;
> -       ccb->n_elem = 0;
> +       ccb = pm8001_ccb_alloc(pm8001_ha, pm8001_ha_dev, task);
> +       if (!ccb) {
> +               sas_free_task(task);
> +               kfree(dev);
> +               return;
> +       }
> +
>         pm8001_ha_dev->id |= NCQ_READ_LOG_FLAG;
>         pm8001_ha_dev->id |= NCQ_2ND_RLE_FLAG;
>
> @@ -1860,7 +1845,7 @@ static void pm8001_send_read_log(struct pm8001_hba_info *pm8001_ha,
>         fis.lbal = 0x10;
>         fis.sector_count = 0x1;
>
> -       sata_cmd.tag = cpu_to_le32(ccb_tag);
> +       sata_cmd.tag = cpu_to_le32(ccb->ccb_tag);
>         sata_cmd.device_id = cpu_to_le32(pm8001_ha_dev->device_id);
>         sata_cmd.ncqtag_atap_dir_m = cpu_to_le32((0x1 << 7) | (0x5 << 9));
>         memcpy(&sata_cmd.sata_fis, &fis, sizeof(struct host_to_dev_fis));
> @@ -1869,7 +1854,7 @@ static void pm8001_send_read_log(struct pm8001_hba_info *pm8001_ha,
>                         sizeof(sata_cmd), 0);
>         if (res) {
>                 sas_free_task(task);
> -               pm8001_tag_free(pm8001_ha, ccb_tag);
> +               pm8001_ccb_free(pm8001_ha, ccb);
>                 kfree(dev);
>         }
>  }
> @@ -3038,12 +3023,12 @@ void pm8001_mpi_set_dev_state_resp(struct pm8001_hba_info *pm8001_ha,
>         u32 device_id = le32_to_cpu(pPayload->device_id);
>         u8 pds = le32_to_cpu(pPayload->pds_nds) & PDS_BITS;
>         u8 nds = le32_to_cpu(pPayload->pds_nds) & NDS_BITS;
> -       pm8001_dbg(pm8001_ha, MSG, "Set device id = 0x%x state from 0x%x to 0x%x status = 0x%x!\n",
> +
> +       pm8001_dbg(pm8001_ha, MSG,
> +                  "Set device id = 0x%x state from 0x%x to 0x%x status = 0x%x!\n",
>                    device_id, pds, nds, status);
>         complete(pm8001_dev->setds_completion);
> -       ccb->task = NULL;
> -       ccb->ccb_tag = PM8001_INVALID_TAG;
> -       pm8001_tag_free(pm8001_ha, tag);
> +       pm8001_ccb_free(pm8001_ha, ccb);
>  }
>
>  void pm8001_mpi_set_nvmd_resp(struct pm8001_hba_info *pm8001_ha, void *piomb)
> @@ -3053,15 +3038,14 @@ void pm8001_mpi_set_nvmd_resp(struct pm8001_hba_info *pm8001_ha, void *piomb)
>         u32 tag = le32_to_cpu(pPayload->tag);
>         struct pm8001_ccb_info *ccb = &pm8001_ha->ccb_info[tag];
>         u32 dlen_status = le32_to_cpu(pPayload->dlen_status);
> +
>         complete(pm8001_ha->nvmd_completion);
>         pm8001_dbg(pm8001_ha, MSG, "Set nvm data complete!\n");
>         if ((dlen_status & NVMD_STAT) != 0) {
>                 pm8001_dbg(pm8001_ha, FAIL, "Set nvm data error %x\n",
>                                 dlen_status);
>         }
> -       ccb->task = NULL;
> -       ccb->ccb_tag = PM8001_INVALID_TAG;
> -       pm8001_tag_free(pm8001_ha, tag);
> +       pm8001_ccb_free(pm8001_ha, ccb);
>  }
>
>  void
> @@ -3086,9 +3070,7 @@ pm8001_mpi_get_nvmd_resp(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 /* We should free tag during failure also, the tag is not being
>                  * freed by requesting path anywhere.
>                  */
> -               ccb->task = NULL;
> -               ccb->ccb_tag = PM8001_INVALID_TAG;
> -               pm8001_tag_free(pm8001_ha, tag);
> +               pm8001_ccb_free(pm8001_ha, ccb);
>                 return;
>         }
>         if (ir_tds_bn_dps_das_nvm & IPMode) {
> @@ -3132,9 +3114,7 @@ pm8001_mpi_get_nvmd_resp(struct pm8001_hba_info *pm8001_ha, void *piomb)
>          */
>         complete(pm8001_ha->nvmd_completion);
>         pm8001_dbg(pm8001_ha, MSG, "Get nvmd data complete!\n");
> -       ccb->task = NULL;
> -       ccb->ccb_tag = PM8001_INVALID_TAG;
> -       pm8001_tag_free(pm8001_ha, tag);
> +       pm8001_ccb_free(pm8001_ha, ccb);
>  }
>
>  int pm8001_mpi_local_phy_ctl(struct pm8001_hba_info *pm8001_ha, void *piomb)
> @@ -3545,9 +3525,7 @@ int pm8001_mpi_reg_resp(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 break;
>         }
>         complete(pm8001_dev->dcompletion);
> -       ccb->task = NULL;
> -       ccb->ccb_tag = PM8001_INVALID_TAG;
> -       pm8001_tag_free(pm8001_ha, htag);
> +       pm8001_ccb_free(pm8001_ha, ccb);
>         return 0;
>  }
>
> @@ -3580,6 +3558,7 @@ int pm8001_mpi_fw_flash_update_resp(struct pm8001_hba_info *pm8001_ha,
>                 (struct fw_flash_Update_resp *)(piomb + 4);
>         u32 tag = le32_to_cpu(ppayload->tag);
>         struct pm8001_ccb_info *ccb = &pm8001_ha->ccb_info[tag];
> +
>         status = le32_to_cpu(ppayload->status);
>         switch (status) {
>         case FLASH_UPDATE_COMPLETE_PENDING_REBOOT:
> @@ -3617,9 +3596,7 @@ int pm8001_mpi_fw_flash_update_resp(struct pm8001_hba_info *pm8001_ha,
>                 break;
>         }
>         kfree(ccb->fw_control_context);
> -       ccb->task = NULL;
> -       ccb->ccb_tag = PM8001_INVALID_TAG;
> -       pm8001_tag_free(pm8001_ha, tag);
> +       pm8001_ccb_free(pm8001_ha, ccb);
>         complete(pm8001_ha->nvmd_completion);
>         return 0;
>  }
> @@ -4412,7 +4389,7 @@ static int pm8001_chip_reg_dev_req(struct pm8001_hba_info *pm8001_ha,
>         u32 stp_sspsmp_sata = 0x4;
>         struct inbound_queue_table *circularQ;
>         u32 linkrate, phy_id;
> -       int rc, tag = 0xdeadbeef;
> +       int rc;
>         struct pm8001_ccb_info *ccb;
>         u8 retryFlag = 0x1;
>         u16 firstBurstSize = 0;
> @@ -4423,13 +4400,11 @@ static int pm8001_chip_reg_dev_req(struct pm8001_hba_info *pm8001_ha,
>         circularQ = &pm8001_ha->inbnd_q_tbl[0];
>
>         memset(&payload, 0, sizeof(payload));
> -       rc = pm8001_tag_alloc(pm8001_ha, &tag);
> -       if (rc)
> -               return rc;
> -       ccb = &pm8001_ha->ccb_info[tag];
> -       ccb->device = pm8001_dev;
> -       ccb->ccb_tag = tag;
> -       payload.tag = cpu_to_le32(tag);
> +       ccb = pm8001_ccb_alloc(pm8001_ha, pm8001_dev, NULL);
> +       if (!ccb)
> +               return -SAS_QUEUE_FULL;
> +
> +       payload.tag = cpu_to_le32(ccb->ccb_tag);
>         if (flag == 1)
>                 stp_sspsmp_sata = 0x02; /*direct attached sata */
>         else {
> @@ -4459,7 +4434,7 @@ static int pm8001_chip_reg_dev_req(struct pm8001_hba_info *pm8001_ha,
>         rc = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &payload,
>                         sizeof(payload), 0);
>         if (rc)
> -               pm8001_tag_free(pm8001_ha, tag);
> +               pm8001_ccb_free(pm8001_ha, ccb);
>
>         return rc;
>  }
> @@ -4624,7 +4599,6 @@ int pm8001_chip_get_nvmd_req(struct pm8001_hba_info *pm8001_ha,
>         u32 opc = OPC_INB_GET_NVMD_DATA;
>         u32 nvmd_type;
>         int rc;
> -       u32 tag;
>         struct pm8001_ccb_info *ccb;
>         struct inbound_queue_table *circularQ;
>         struct get_nvm_data_req nvmd_req;
> @@ -4639,15 +4613,15 @@ int pm8001_chip_get_nvmd_req(struct pm8001_hba_info *pm8001_ha,
>         fw_control_context->len = ioctl_payload->rd_length;
>         circularQ = &pm8001_ha->inbnd_q_tbl[0];
>         memset(&nvmd_req, 0, sizeof(nvmd_req));
> -       rc = pm8001_tag_alloc(pm8001_ha, &tag);
> -       if (rc) {
> +
> +       ccb = pm8001_ccb_alloc(pm8001_ha, NULL, NULL);
> +       if (!ccb) {
>                 kfree(fw_control_context);
> -               return rc;
> +               return -SAS_QUEUE_FULL;
>         }
> -       ccb = &pm8001_ha->ccb_info[tag];
> -       ccb->ccb_tag = tag;
>         ccb->fw_control_context = fw_control_context;
> -       nvmd_req.tag = cpu_to_le32(tag);
> +
> +       nvmd_req.tag = cpu_to_le32(ccb->ccb_tag);
>
>         switch (nvmd_type) {
>         case TWI_DEVICE: {
> @@ -4708,7 +4682,7 @@ int pm8001_chip_get_nvmd_req(struct pm8001_hba_info *pm8001_ha,
>                         sizeof(nvmd_req), 0);
>         if (rc) {
>                 kfree(fw_control_context);
> -               pm8001_tag_free(pm8001_ha, tag);
> +               pm8001_ccb_free(pm8001_ha, ccb);
>         }
>         return rc;
>  }
> @@ -4719,7 +4693,6 @@ int pm8001_chip_set_nvmd_req(struct pm8001_hba_info *pm8001_ha,
>         u32 opc = OPC_INB_SET_NVMD_DATA;
>         u32 nvmd_type;
>         int rc;
> -       u32 tag;
>         struct pm8001_ccb_info *ccb;
>         struct inbound_queue_table *circularQ;
>         struct set_nvm_data_req nvmd_req;
> @@ -4735,15 +4708,15 @@ int pm8001_chip_set_nvmd_req(struct pm8001_hba_info *pm8001_ha,
>                 &ioctl_payload->func_specific,
>                 ioctl_payload->wr_length);
>         memset(&nvmd_req, 0, sizeof(nvmd_req));
> -       rc = pm8001_tag_alloc(pm8001_ha, &tag);
> -       if (rc) {
> +
> +       ccb = pm8001_ccb_alloc(pm8001_ha, NULL, NULL);
> +       if (!ccb) {
>                 kfree(fw_control_context);
> -               return -EBUSY;
> +               return -SAS_QUEUE_FULL;
>         }
> -       ccb = &pm8001_ha->ccb_info[tag];
>         ccb->fw_control_context = fw_control_context;
> -       ccb->ccb_tag = tag;
> -       nvmd_req.tag = cpu_to_le32(tag);
> +
> +       nvmd_req.tag = cpu_to_le32(ccb->ccb_tag);
>         switch (nvmd_type) {
>         case TWI_DEVICE: {
>                 u32 twi_addr, twi_page_size;
> @@ -4793,7 +4766,7 @@ int pm8001_chip_set_nvmd_req(struct pm8001_hba_info *pm8001_ha,
>                         sizeof(nvmd_req), 0);
>         if (rc) {
>                 kfree(fw_control_context);
> -               pm8001_tag_free(pm8001_ha, tag);
> +               pm8001_ccb_free(pm8001_ha, ccb);
>         }
>         return rc;
>  }
> @@ -4839,7 +4812,6 @@ pm8001_chip_fw_flash_update_req(struct pm8001_hba_info *pm8001_ha,
>         struct fw_control_info *fw_control;
>         struct fw_control_ex *fw_control_context;
>         int rc;
> -       u32 tag;
>         struct pm8001_ccb_info *ccb;
>         void *buffer = pm8001_ha->memoryMap.region[FW_FLASH].virt_ptr;
>         dma_addr_t phys_addr = pm8001_ha->memoryMap.region[FW_FLASH].phys_addr;
> @@ -4863,19 +4835,19 @@ pm8001_chip_fw_flash_update_req(struct pm8001_hba_info *pm8001_ha,
>         fw_control_context->virtAddr = buffer;
>         fw_control_context->phys_addr = phys_addr;
>         fw_control_context->len = fw_control->len;
> -       rc = pm8001_tag_alloc(pm8001_ha, &tag);
> -       if (rc) {
> +
> +       ccb = pm8001_ccb_alloc(pm8001_ha, NULL, NULL);
> +       if (!ccb) {
>                 kfree(fw_control_context);
> -               return -EBUSY;
> +               return -SAS_QUEUE_FULL;
>         }
> -       ccb = &pm8001_ha->ccb_info[tag];
>         ccb->fw_control_context = fw_control_context;
> -       ccb->ccb_tag = tag;
> +
>         rc = pm8001_chip_fw_flash_update_build(pm8001_ha, &flash_update_info,
> -               tag);
> +                                              ccb->ccb_tag);
>         if (rc) {
>                 kfree(fw_control_context);
> -               pm8001_tag_free(pm8001_ha, tag);
> +               pm8001_ccb_free(pm8001_ha, ccb);
>         }
>
>         return rc;
> @@ -4967,26 +4939,25 @@ pm8001_chip_set_dev_state_req(struct pm8001_hba_info *pm8001_ha,
>         struct inbound_queue_table *circularQ;
>         struct pm8001_ccb_info *ccb;
>         int rc;
> -       u32 tag;
>         u32 opc = OPC_INB_SET_DEVICE_STATE;
> +
>         memset(&payload, 0, sizeof(payload));
> -       rc = pm8001_tag_alloc(pm8001_ha, &tag);
> -       if (rc)
> -               return -1;
> -       ccb = &pm8001_ha->ccb_info[tag];
> -       ccb->ccb_tag = tag;
> -       ccb->device = pm8001_dev;
> +
> +       ccb = pm8001_ccb_alloc(pm8001_ha, pm8001_dev, NULL);
> +       if (!ccb)
> +               return -SAS_QUEUE_FULL;
> +
>         circularQ = &pm8001_ha->inbnd_q_tbl[0];
> -       payload.tag = cpu_to_le32(tag);
> +       payload.tag = cpu_to_le32(ccb->ccb_tag);
>         payload.device_id = cpu_to_le32(pm8001_dev->device_id);
>         payload.nds = cpu_to_le32(state);
> +
>         rc = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &payload,
>                         sizeof(payload), 0);
>         if (rc)
> -               pm8001_tag_free(pm8001_ha, tag);
> +               pm8001_ccb_free(pm8001_ha, ccb);
>
>         return rc;
> -
>  }
>
>  static int
> @@ -4996,25 +4967,26 @@ pm8001_chip_sas_re_initialization(struct pm8001_hba_info *pm8001_ha)
>         struct inbound_queue_table *circularQ;
>         struct pm8001_ccb_info *ccb;
>         int rc;
> -       u32 tag;
>         u32 opc = OPC_INB_SAS_RE_INITIALIZE;
> +
>         memset(&payload, 0, sizeof(payload));
> -       rc = pm8001_tag_alloc(pm8001_ha, &tag);
> -       if (rc)
> -               return -ENOMEM;
> -       ccb = &pm8001_ha->ccb_info[tag];
> -       ccb->ccb_tag = tag;
> +
> +       ccb = pm8001_ccb_alloc(pm8001_ha, NULL, NULL);
> +       if (!ccb)
> +               return -SAS_QUEUE_FULL;
> +
>         circularQ = &pm8001_ha->inbnd_q_tbl[0];
> -       payload.tag = cpu_to_le32(tag);
> +       payload.tag = cpu_to_le32(ccb->ccb_tag);
>         payload.SSAHOLT = cpu_to_le32(0xd << 25);
>         payload.sata_hol_tmo = cpu_to_le32(80);
>         payload.open_reject_cmdretries_data_retries = cpu_to_le32(0xff00ff);
> +
>         rc = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &payload,
>                         sizeof(payload), 0);
>         if (rc)
> -               pm8001_tag_free(pm8001_ha, tag);
> -       return rc;
> +               pm8001_ccb_free(pm8001_ha, ccb);
>
> +       return rc;
>  }
>
>  const struct pm8001_dispatch pm8001_8001_dispatch = {
> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
> index 1e60ad82635e..52507bc8f963 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.c
> +++ b/drivers/scsi/pm8001/pm8001_sas.c
> @@ -74,7 +74,7 @@ void pm8001_tag_free(struct pm8001_hba_info *pm8001_ha, u32 tag)
>    * @pm8001_ha: our hba struct
>    * @tag_out: the found empty tag .
>    */
> -inline int pm8001_tag_alloc(struct pm8001_hba_info *pm8001_ha, u32 *tag_out)
> +int pm8001_tag_alloc(struct pm8001_hba_info *pm8001_ha, u32 *tag_out)
>  {
>         unsigned int tag;
>         void *bitmap = pm8001_ha->tags;
> @@ -382,7 +382,7 @@ static int pm8001_task_exec(struct sas_task *task,
>         struct pm8001_port *port = NULL;
>         struct sas_task *t = task;
>         struct pm8001_ccb_info *ccb;
> -       u32 tag = 0xdeadbeef, rc = 0, n_elem = 0;
> +       u32 rc = 0, n_elem = 0;
>         unsigned long flags = 0;
>         enum sas_protocol task_proto = t->task_proto;
>
> @@ -426,10 +426,12 @@ static int pm8001_task_exec(struct sas_task *task,
>                                 continue;
>                         }
>                 }
> -               rc = pm8001_tag_alloc(pm8001_ha, &tag);
> -               if (rc)
> +
> +               ccb = pm8001_ccb_alloc(pm8001_ha, pm8001_dev, t);
> +               if (!ccb) {
> +                       rc = -SAS_QUEUE_FULL;
>                         goto err_out;
> -               ccb = &pm8001_ha->ccb_info[tag];
> +               }
>
>                 if (!sas_protocol_ata(task_proto)) {
>                         if (t->num_scatter) {
> @@ -439,7 +441,7 @@ static int pm8001_task_exec(struct sas_task *task,
>                                         t->data_dir);
>                                 if (!n_elem) {
>                                         rc = -ENOMEM;
> -                                       goto err_out_tag;
> +                                       goto err_out_ccb;
>                                 }
>                         }
>                 } else {
> @@ -448,9 +450,7 @@ static int pm8001_task_exec(struct sas_task *task,
>
>                 t->lldd_task = ccb;
>                 ccb->n_elem = n_elem;
> -               ccb->ccb_tag = tag;
> -               ccb->task = t;
> -               ccb->device = pm8001_dev;
> +
>                 switch (task_proto) {
>                 case SAS_PROTOCOL_SMP:
>                         atomic_inc(&pm8001_dev->running_req);
> @@ -479,15 +479,15 @@ static int pm8001_task_exec(struct sas_task *task,
>                 if (rc) {
>                         pm8001_dbg(pm8001_ha, IO, "rc is %x\n", rc);
>                         atomic_dec(&pm8001_dev->running_req);
> -                       goto err_out_tag;
> +                       goto err_out_ccb;
>                 }
>                 /* TODO: select normal or high priority */
>         } while (0);
>         rc = 0;
>         goto out_done;
>
> -err_out_tag:
> -       pm8001_tag_free(pm8001_ha, tag);
> +err_out_ccb:
> +       pm8001_ccb_free(pm8001_ha, ccb);
>  err_out:
>         dev_printk(KERN_ERR, pm8001_ha->dev, "pm8001 exec failed[%d]!\n", rc);
>         if (!sas_protocol_ata(task_proto))
> @@ -558,10 +558,7 @@ void pm8001_ccb_task_free(struct pm8001_hba_info *pm8001_ha,
>         }
>
>         task->lldd_task = NULL;
> -       ccb->task = NULL;
> -       ccb->ccb_tag = PM8001_INVALID_TAG;
> -       ccb->open_retry = 0;
> -       pm8001_tag_free(pm8001_ha, ccb_idx);
> +       pm8001_ccb_free(pm8001_ha, ccb);
>  }
>
>  /**
> @@ -812,7 +809,6 @@ pm8001_exec_internal_task_abort(struct pm8001_hba_info *pm8001_ha,
>         u32 task_tag)
>  {
>         int res, retry;
> -       u32 ccb_tag;
>         struct pm8001_ccb_info *ccb;
>         struct sas_task *task = NULL;
>
> @@ -828,23 +824,19 @@ pm8001_exec_internal_task_abort(struct pm8001_hba_info *pm8001_ha,
>                 task->slow_task->timer.expires = jiffies + PM8001_TASK_TIMEOUT * HZ;
>                 add_timer(&task->slow_task->timer);
>
> -               res = pm8001_tag_alloc(pm8001_ha, &ccb_tag);
> -               if (res)
> +               ccb = pm8001_ccb_alloc(pm8001_ha, pm8001_dev, task);
> +               if (!ccb) {
> +                       res = -SAS_QUEUE_FULL;
>                         break;
> -
> -               ccb = &pm8001_ha->ccb_info[ccb_tag];
> -               ccb->device = pm8001_dev;
> -               ccb->ccb_tag = ccb_tag;
> -               ccb->task = task;
> -               ccb->n_elem = 0;
> +               }
>
>                 res = PM8001_CHIP_DISP->task_abort(pm8001_ha,
> -                       pm8001_dev, flag, task_tag, ccb_tag);
> +                       pm8001_dev, flag, task_tag, ccb->ccb_tag);
>                 if (res) {
>                         del_timer(&task->slow_task->timer);
>                         pm8001_dbg(pm8001_ha, FAIL,
>                                    "Executing internal task failed\n");
> -                       pm8001_tag_free(pm8001_ha, ccb_tag);
> +                       pm8001_ccb_free(pm8001_ha, ccb);
>                         break;
>                 }
>
> diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
> index 1791cdf30276..824ada7f6a3f 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.h
> +++ b/drivers/scsi/pm8001/pm8001_sas.h
> @@ -740,6 +740,53 @@ extern const struct attribute_group *pm8001_host_groups[];
>
>  #define PM8001_INVALID_TAG     ((u32)-1)
>
> +/*
> + * Allocate a new tag and return the corresponding ccb after initializing it.
> + */
> +static inline struct pm8001_ccb_info *
> +pm8001_ccb_alloc(struct pm8001_hba_info *pm8001_ha,
> +                struct pm8001_device *dev, struct sas_task *task)
> +{
> +       struct pm8001_ccb_info *ccb;
> +       u32 tag;
> +
> +       if (pm8001_tag_alloc(pm8001_ha, &tag)) {
> +               pm8001_dbg(pm8001_ha, FAIL, "Failed to allocate a tag\n");
> +               return NULL;
> +       }
> +
> +       ccb = &pm8001_ha->ccb_info[tag];
> +       ccb->task = task;
> +       ccb->n_elem = 0;
> +       ccb->ccb_tag = tag;
> +       ccb->device = dev;
> +       ccb->fw_control_context = NULL;
> +       ccb->open_retry = 0;
> +
> +       return ccb;
> +}
> +
> +/*
> + * Free the tag of an initialized ccb.
> + */
> +static inline void pm8001_ccb_free(struct pm8001_hba_info *pm8001_ha,
> +                                  struct pm8001_ccb_info *ccb)
> +{
> +       u32 tag = ccb->ccb_tag;
> +
> +       /*
> +        * Cleanup the ccb to make sure that a manual scan of the adapter
> +        * ccb_info array can detect ccb's that are in use.
> +        * C.f. pm8001_open_reject_retry()
> +        */
> +       ccb->task = NULL;
> +       ccb->ccb_tag = PM8001_INVALID_TAG;
> +       ccb->device = NULL;
> +       ccb->fw_control_context = NULL;
> +
> +       pm8001_tag_free(pm8001_ha, tag);
> +}
> +
>  static inline void
>  pm8001_ccb_task_free_done(struct pm8001_hba_info *pm8001_ha,
>                         struct sas_task *task, struct pm8001_ccb_info *ccb,
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
> index 4419fdb0db78..57ea933dab66 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> @@ -1767,8 +1767,6 @@ pm80xx_chip_interrupt_disable(struct pm8001_hba_info *pm8001_ha, u8 vec)
>  static void pm80xx_send_abort_all(struct pm8001_hba_info *pm8001_ha,
>                 struct pm8001_device *pm8001_ha_dev)
>  {
> -       int res;
> -       u32 ccb_tag;
>         struct pm8001_ccb_info *ccb;
>         struct sas_task *task = NULL;
>         struct task_abort_req task_abort;
> @@ -1790,31 +1788,25 @@ static void pm80xx_send_abort_all(struct pm8001_hba_info *pm8001_ha,
>
>         task->task_done = pm8001_task_done;
>
> -       res = pm8001_tag_alloc(pm8001_ha, &ccb_tag);
> -       if (res) {
> +       ccb = pm8001_ccb_alloc(pm8001_ha, pm8001_ha_dev, task);
> +       if (!ccb) {
>                 sas_free_task(task);
>                 return;
>         }
>
> -       ccb = &pm8001_ha->ccb_info[ccb_tag];
> -       ccb->device = pm8001_ha_dev;
> -       ccb->ccb_tag = ccb_tag;
> -       ccb->task = task;
> -       ccb->n_elem = 0;
> -
>         circularQ = &pm8001_ha->inbnd_q_tbl[0];
>
>         memset(&task_abort, 0, sizeof(task_abort));
>         task_abort.abort_all = cpu_to_le32(1);
>         task_abort.device_id = cpu_to_le32(pm8001_ha_dev->device_id);
> -       task_abort.tag = cpu_to_le32(ccb_tag);
> +       task_abort.tag = cpu_to_le32(ccb->ccb_tag);
>
>         ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &task_abort,
>                         sizeof(task_abort), 0);
>         pm8001_dbg(pm8001_ha, FAIL, "Executing abort task end\n");
>         if (ret) {
>                 sas_free_task(task);
> -               pm8001_tag_free(pm8001_ha, ccb_tag);
> +               pm8001_ccb_free(pm8001_ha, ccb);
>         }
>  }
>
> @@ -1823,7 +1815,6 @@ static void pm80xx_send_read_log(struct pm8001_hba_info *pm8001_ha,
>  {
>         struct sata_start_req sata_cmd;
>         int res;
> -       u32 ccb_tag;
>         struct pm8001_ccb_info *ccb;
>         struct sas_task *task = NULL;
>         struct host_to_dev_fis fis;
> @@ -1839,20 +1830,13 @@ static void pm80xx_send_read_log(struct pm8001_hba_info *pm8001_ha,
>         }
>         task->task_done = pm8001_task_done;
>
> -       res = pm8001_tag_alloc(pm8001_ha, &ccb_tag);
> -       if (res) {
> -               sas_free_task(task);
> -               pm8001_dbg(pm8001_ha, FAIL, "cannot allocate tag !!!\n");
> -               return;
> -       }
> -
> -       /* allocate domain device by ourselves as libsas
> -        * is not going to provide any
> -       */
> +       /*
> +        * Allocate domain device by ourselves as libsas is not going to
> +        * provide any.
> +        */
>         dev = kzalloc(sizeof(struct domain_device), GFP_ATOMIC);
>         if (!dev) {
>                 sas_free_task(task);
> -               pm8001_tag_free(pm8001_ha, ccb_tag);
>                 pm8001_dbg(pm8001_ha, FAIL,
>                            "Domain device cannot be allocated\n");
>                 return;
> @@ -1861,11 +1845,13 @@ static void pm80xx_send_read_log(struct pm8001_hba_info *pm8001_ha,
>         task->dev = dev;
>         task->dev->lldd_dev = pm8001_ha_dev;
>
> -       ccb = &pm8001_ha->ccb_info[ccb_tag];
> -       ccb->device = pm8001_ha_dev;
> -       ccb->ccb_tag = ccb_tag;
> -       ccb->task = task;
> -       ccb->n_elem = 0;
> +       ccb = pm8001_ccb_alloc(pm8001_ha, pm8001_ha_dev, task);
> +       if (!ccb) {
> +               sas_free_task(task);
> +               kfree(dev);
> +               return;
> +       }
> +
>         pm8001_ha_dev->id |= NCQ_READ_LOG_FLAG;
>         pm8001_ha_dev->id |= NCQ_2ND_RLE_FLAG;
>
> @@ -1880,7 +1866,7 @@ static void pm80xx_send_read_log(struct pm8001_hba_info *pm8001_ha,
>         fis.lbal = 0x10;
>         fis.sector_count = 0x1;
>
> -       sata_cmd.tag = cpu_to_le32(ccb_tag);
> +       sata_cmd.tag = cpu_to_le32(ccb->ccb_tag);
>         sata_cmd.device_id = cpu_to_le32(pm8001_ha_dev->device_id);
>         sata_cmd.ncqtag_atap_dir_m_dad = cpu_to_le32(((0x1 << 7) | (0x5 << 9)));
>         memcpy(&sata_cmd.sata_fis, &fis, sizeof(struct host_to_dev_fis));
> @@ -1890,7 +1876,7 @@ static void pm80xx_send_read_log(struct pm8001_hba_info *pm8001_ha,
>         pm8001_dbg(pm8001_ha, FAIL, "Executing read log end\n");
>         if (res) {
>                 sas_free_task(task);
> -               pm8001_tag_free(pm8001_ha, ccb_tag);
> +               pm8001_ccb_free(pm8001_ha, ccb);
>                 kfree(dev);
>         }
>  }
> @@ -4834,7 +4820,7 @@ static int pm80xx_chip_reg_dev_req(struct pm8001_hba_info *pm8001_ha,
>         u32 stp_sspsmp_sata = 0x4;
>         struct inbound_queue_table *circularQ;
>         u32 linkrate, phy_id;
> -       int rc, tag = 0xdeadbeef;
> +       int rc;
>         struct pm8001_ccb_info *ccb;
>         u8 retryFlag = 0x1;
>         u16 firstBurstSize = 0;
> @@ -4845,13 +4831,11 @@ static int pm80xx_chip_reg_dev_req(struct pm8001_hba_info *pm8001_ha,
>         circularQ = &pm8001_ha->inbnd_q_tbl[0];
>
>         memset(&payload, 0, sizeof(payload));
> -       rc = pm8001_tag_alloc(pm8001_ha, &tag);
> -       if (rc)
> -               return rc;
> -       ccb = &pm8001_ha->ccb_info[tag];
> -       ccb->device = pm8001_dev;
> -       ccb->ccb_tag = tag;
> -       payload.tag = cpu_to_le32(tag);
> +       ccb = pm8001_ccb_alloc(pm8001_ha, pm8001_dev, NULL);
> +       if (!ccb)
> +               return -SAS_QUEUE_FULL;
> +
> +       payload.tag = cpu_to_le32(ccb->ccb_tag);
>
>         if (flag == 1) {
>                 stp_sspsmp_sata = 0x02; /*direct attached sata */
> @@ -4888,7 +4872,7 @@ static int pm80xx_chip_reg_dev_req(struct pm8001_hba_info *pm8001_ha,
>         rc = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &payload,
>                         sizeof(payload), 0);
>         if (rc)
> -               pm8001_tag_free(pm8001_ha, tag);
> +               pm8001_ccb_free(pm8001_ha, ccb);
>
>         return rc;
>  }
> --
> 2.34.1
>
