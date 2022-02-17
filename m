Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2BE4BAA12
	for <lists+linux-scsi@lfdr.de>; Thu, 17 Feb 2022 20:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238958AbiBQTrP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 17 Feb 2022 14:47:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiBQTrO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 17 Feb 2022 14:47:14 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06872612C
        for <linux-scsi@vger.kernel.org>; Thu, 17 Feb 2022 11:46:57 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id vz16so9884641ejb.0
        for <linux-scsi@vger.kernel.org>; Thu, 17 Feb 2022 11:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pBC45yFNsG0tSlR3KekyzySQZDM2pQVumC+xzARA/kw=;
        b=ItLHN4BWPNPtZzkM42IzTeprHVdwM9eS78AkZRgOsDJ1UzX7Z8pc+GceUI65gmsfyy
         9V0yE3M5pPOvYq8bsV3ZXieef1RJQq+tun1+xfCNfz2kJWOW26q/szMq16oua28mphKA
         o+W3FqojEB23tFsMtjLyUnci/7ylbytuMtQiqPGIjU64dvYwYAxDQ+B80LkQhGGZk+fO
         ZgjsPYMPmhJM8oQJbd2DyU5OCmI2D4zi570r+8Aiur0A73VKoqpuQBA7HwRMkR5vlMP0
         fGxqQljJceZFLxrdjdBi5zgQsiXShnyAj728IskMLBVRvEfWE3Y2PtcNg18JsMhel+i9
         4ruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pBC45yFNsG0tSlR3KekyzySQZDM2pQVumC+xzARA/kw=;
        b=re1ROeErUuTbaOQkAgTXDLxxFgIgYD3dNujH7+M9+c/mBU8Ul6G41aM7rfD5VqV7Em
         JnbDtJ1RftjHSd3T25gLTdiqGjCntn5LUA4NitNPE+8KMSMcUv2HaRkW+2Y99mcFwE3R
         X1pIBdBVrz5f/VnWZuerIpfLzUhMQ74rK5B0n8IBABP5JwvbCnhXLqI4UF/TH0nPSaxG
         GdF1PAC24UXArEpNYPuBt+EoyM+Xlmyk/AQMJj5snOR3PAbqZoJORuGR8KVretxIxBbH
         ErSlZF7XUTAobkzKUnvKZrgRYyVh9GO7bWph5HoXfQTQnXYTvHPFdhmWvzZ4gjPSjz7R
         CHXA==
X-Gm-Message-State: AOAM532pTFj4UEW5hLILpbyTni+0cpkwkjPgcmwY0Nup6vPYUcc6wuhh
        qXNKVBZgQRmN8t1Nd8NLLgieCNSbAl6YN+LG+8quSw==
X-Google-Smtp-Source: ABdhPJz8C5W4oNdfY6L6c4waZBGypFJRWNPPn54j5gw7DGPy1jba40UCeKpTIuHWSAv7bwDar4clcMiaVfJHG4RaGMw=
X-Received: by 2002:a17:906:8051:b0:6ce:a85d:ed74 with SMTP id
 x17-20020a170906805100b006cea85ded74mr3598655ejw.58.1645127215801; Thu, 17
 Feb 2022 11:46:55 -0800 (PST)
MIME-Version: 1.0
References: <20220217132956.484818-1-damien.lemoal@opensource.wdc.com> <20220217132956.484818-28-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220217132956.484818-28-damien.lemoal@opensource.wdc.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 17 Feb 2022 20:46:44 +0100
Message-ID: <CAMGffEkwA0TDp6G4cODRN5L9QKgdsZNg2N-e-rzkzOeuAufdDw@mail.gmail.com>
Subject: Re: [PATCH v4 27/31] scsi: pm8001: Simplify pm8001_mpi_build_cmd() interface
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
> There is no need to pass a pointer to a struct inbound_queue_table to
> pm8001_mpi_build_cmd(). Passing the start index in the inbound queue
> table of the adapter is enough. This change allows avoiding the
> declaration of a struct inbound_queue_table pointer (circularQ
> variables) in many functions, simplifying the code.
>
> While at it, blank lines are added i(e.g. after local variable
> declarations) to make the code more readable.
>
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/scsi/pm8001/pm8001_hwi.c | 154 +++++++++++--------------------
>  drivers/scsi/pm8001/pm8001_sas.h |   3 +-
>  drivers/scsi/pm8001/pm80xx_hwi.c |  98 +++++++-------------
>  3 files changed, 89 insertions(+), 166 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
> index 699fecc09267..03bcf7497bf9 100644
> --- a/drivers/scsi/pm8001/pm8001_hwi.c
> +++ b/drivers/scsi/pm8001/pm8001_hwi.c
> @@ -1309,21 +1309,20 @@ int pm8001_mpi_msg_free_get(struct inbound_queue_table *circularQ,
>   * pm8001_mpi_build_cmd- build the message queue for transfer, update the PI to
>   * FW to tell the fw to get this message from IOMB.
>   * @pm8001_ha: our hba card information
> - * @circularQ: the inbound queue we want to transfer to HBA.
> + * @q_index: the index in the inbound queue we want to transfer to HBA.
>   * @opCode: the operation code represents commands which LLDD and fw recognized.
>   * @payload: the command payload of each operation command.
>   * @nb: size in bytes of the command payload
>   * @responseQueue: queue to interrupt on w/ command response (if any)
>   */
>  int pm8001_mpi_build_cmd(struct pm8001_hba_info *pm8001_ha,
> -                        struct inbound_queue_table *circularQ,
> -                        u32 opCode, void *payload, size_t nb,
> +                        u32 q_index, u32 opCode, void *payload, size_t nb,
>                          u32 responseQueue)
>  {
>         u32 Header = 0, hpriority = 0, bc = 1, category = 0x02;
>         void *pMessage;
>         unsigned long flags;
> -       int q_index = circularQ - pm8001_ha->inbnd_q_tbl;
> +       struct inbound_queue_table *circularQ = &pm8001_ha->inbnd_q_tbl[q_index];
>         int rv;
>         u32 htag = le32_to_cpu(*(__le32 *)payload);
>
> @@ -1752,7 +1751,6 @@ static void pm8001_send_abort_all(struct pm8001_hba_info *pm8001_ha,
>         struct pm8001_ccb_info *ccb;
>         struct sas_task *task = NULL;
>         struct task_abort_req task_abort;
> -       struct inbound_queue_table *circularQ;
>         u32 opc = OPC_INB_SATA_ABORT;
>         int ret;
>
> @@ -1775,15 +1773,13 @@ static void pm8001_send_abort_all(struct pm8001_hba_info *pm8001_ha,
>                 return;
>         }
>
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
> -
>         memset(&task_abort, 0, sizeof(task_abort));
>         task_abort.abort_all = cpu_to_le32(1);
>         task_abort.device_id = cpu_to_le32(pm8001_ha_dev->device_id);
>         task_abort.tag = cpu_to_le32(ccb->ccb_tag);
>
> -       ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &task_abort,
> -                       sizeof(task_abort), 0);
> +       ret = pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &task_abort,
> +                                  sizeof(task_abort), 0);
>         if (ret) {
>                 sas_free_task(task);
>                 pm8001_ccb_free(pm8001_ha, ccb);
> @@ -1799,11 +1795,9 @@ static void pm8001_send_read_log(struct pm8001_hba_info *pm8001_ha,
>         struct sas_task *task = NULL;
>         struct host_to_dev_fis fis;
>         struct domain_device *dev;
> -       struct inbound_queue_table *circularQ;
>         u32 opc = OPC_INB_SATA_HOST_OPSTART;
>
>         task = sas_alloc_slow_task(GFP_ATOMIC);
> -
>         if (!task) {
>                 pm8001_dbg(pm8001_ha, FAIL, "cannot allocate task !!!\n");
>                 return;
> @@ -1834,9 +1828,6 @@ static void pm8001_send_read_log(struct pm8001_hba_info *pm8001_ha,
>         pm8001_ha_dev->id |= NCQ_READ_LOG_FLAG;
>         pm8001_ha_dev->id |= NCQ_2ND_RLE_FLAG;
>
> -       memset(&sata_cmd, 0, sizeof(sata_cmd));
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
> -
>         /* construct read log FIS */
>         memset(&fis, 0, sizeof(struct host_to_dev_fis));
>         fis.fis_type = 0x27;
> @@ -1845,13 +1836,14 @@ static void pm8001_send_read_log(struct pm8001_hba_info *pm8001_ha,
>         fis.lbal = 0x10;
>         fis.sector_count = 0x1;
>
> +       memset(&sata_cmd, 0, sizeof(sata_cmd));
>         sata_cmd.tag = cpu_to_le32(ccb->ccb_tag);
>         sata_cmd.device_id = cpu_to_le32(pm8001_ha_dev->device_id);
>         sata_cmd.ncqtag_atap_dir_m = cpu_to_le32((0x1 << 7) | (0x5 << 9));
>         memcpy(&sata_cmd.sata_fis, &fis, sizeof(struct host_to_dev_fis));
>
> -       res = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &sata_cmd,
> -                       sizeof(sata_cmd), 0);
> +       res = pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &sata_cmd,
> +                                  sizeof(sata_cmd), 0);
>         if (res) {
>                 sas_free_task(task);
>                 pm8001_ccb_free(pm8001_ha, ccb);
> @@ -3261,17 +3253,14 @@ static void pm8001_hw_event_ack_req(struct pm8001_hba_info *pm8001_ha,
>         struct hw_event_ack_req  payload;
>         u32 opc = OPC_INB_SAS_HW_EVENT_ACK;
>
> -       struct inbound_queue_table *circularQ;
> -
>         memset((u8 *)&payload, 0, sizeof(payload));
> -       circularQ = &pm8001_ha->inbnd_q_tbl[Qnum];
>         payload.tag = cpu_to_le32(1);
>         payload.sea_phyid_portid = cpu_to_le32(((SEA & 0xFFFF) << 8) |
>                 ((phyId & 0x0F) << 4) | (port_id & 0x0F));
>         payload.param0 = cpu_to_le32(param0);
>         payload.param1 = cpu_to_le32(param1);
> -       pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &payload,
> -                       sizeof(payload), 0);
> +
> +       pm8001_mpi_build_cmd(pm8001_ha, Qnum, opc, &payload, sizeof(payload), 0);
>  }
>
>  static int pm8001_chip_phy_ctl_req(struct pm8001_hba_info *pm8001_ha,
> @@ -4103,7 +4092,6 @@ static int pm8001_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
>         u32 req_len, resp_len;
>         struct smp_req smp_cmd;
>         u32 opc;
> -       struct inbound_queue_table *circularQ;
>
>         memset(&smp_cmd, 0, sizeof(smp_cmd));
>         /*
> @@ -4129,7 +4117,6 @@ static int pm8001_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
>         }
>
>         opc = OPC_INB_SMP_REQUEST;
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
>         smp_cmd.tag = cpu_to_le32(ccb->ccb_tag);
>         smp_cmd.long_smp_req.long_req_addr =
>                 cpu_to_le64((u64)sg_dma_address(&task->smp_task.smp_req));
> @@ -4140,8 +4127,8 @@ static int pm8001_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
>         smp_cmd.long_smp_req.long_resp_size =
>                 cpu_to_le32((u32)sg_dma_len(&task->smp_task.smp_resp)-4);
>         build_smp_cmd(pm8001_dev->device_id, smp_cmd.tag, &smp_cmd);
> -       rc = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc,
> -                       &smp_cmd, sizeof(smp_cmd), 0);
> +       rc = pm8001_mpi_build_cmd(pm8001_ha, 0, opc,
> +                                 &smp_cmd, sizeof(smp_cmd), 0);
>         if (rc)
>                 goto err_out_2;
>
> @@ -4169,9 +4156,7 @@ static int pm8001_chip_ssp_io_req(struct pm8001_hba_info *pm8001_ha,
>         struct pm8001_device *pm8001_dev = dev->lldd_dev;
>         struct ssp_ini_io_start_req ssp_cmd;
>         u32 tag = ccb->ccb_tag;
> -       int ret;
>         u64 phys_addr;
> -       struct inbound_queue_table *circularQ;
>         u32 opc = OPC_INB_SSPINIIOSTART;
>         memset(&ssp_cmd, 0, sizeof(ssp_cmd));
>         memcpy(ssp_cmd.ssp_iu.lun, task->ssp_task.LUN, 8);
> @@ -4187,7 +4172,6 @@ static int pm8001_chip_ssp_io_req(struct pm8001_hba_info *pm8001_ha,
>         ssp_cmd.ssp_iu.efb_prio_attr |= (task->ssp_task.task_attr & 7);
>         memcpy(ssp_cmd.ssp_iu.cdb, task->ssp_task.cmd->cmnd,
>                task->ssp_task.cmd->cmd_len);
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
>
>         /* fill in PRD (scatter/gather) table, if any */
>         if (task->num_scatter > 1) {
> @@ -4208,9 +4192,9 @@ static int pm8001_chip_ssp_io_req(struct pm8001_hba_info *pm8001_ha,
>                 ssp_cmd.len = cpu_to_le32(task->total_xfer_len);
>                 ssp_cmd.esgl = 0;
>         }
> -       ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &ssp_cmd,
> -                       sizeof(ssp_cmd), 0);
> -       return ret;
> +
> +       return pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &ssp_cmd,
> +                                   sizeof(ssp_cmd), 0);
>  }
>
>  static int pm8001_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
> @@ -4220,17 +4204,15 @@ static int pm8001_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
>         struct domain_device *dev = task->dev;
>         struct pm8001_device *pm8001_ha_dev = dev->lldd_dev;
>         u32 tag = ccb->ccb_tag;
> -       int ret;
>         struct sata_start_req sata_cmd;
>         u32 hdr_tag, ncg_tag = 0;
>         u64 phys_addr;
>         u32 ATAP = 0x0;
>         u32 dir;
> -       struct inbound_queue_table *circularQ;
>         unsigned long flags;
>         u32  opc = OPC_INB_SATA_HOST_OPSTART;
> +
>         memset(&sata_cmd, 0, sizeof(sata_cmd));
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
>
>         if (task->data_dir == DMA_NONE && !task->ata_task.use_ncq) {
>                 ATAP = 0x04;  /* no data*/
> @@ -4316,9 +4298,8 @@ static int pm8001_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
>                 }
>         }
>
> -       ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &sata_cmd,
> -                       sizeof(sata_cmd), 0);
> -       return ret;
> +       return pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &sata_cmd,
> +                                   sizeof(sata_cmd), 0);
>  }
>
>  /**
> @@ -4330,11 +4311,9 @@ static int
>  pm8001_chip_phy_start_req(struct pm8001_hba_info *pm8001_ha, u8 phy_id)
>  {
>         struct phy_start_req payload;
> -       struct inbound_queue_table *circularQ;
> -       int ret;
>         u32 tag = 0x01;
>         u32 opcode = OPC_INB_PHYSTART;
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
> +
>         memset(&payload, 0, sizeof(payload));
>         payload.tag = cpu_to_le32(tag);
>         /*
> @@ -4351,9 +4330,9 @@ pm8001_chip_phy_start_req(struct pm8001_hba_info *pm8001_ha, u8 phy_id)
>         memcpy(payload.sas_identify.sas_addr,
>                 pm8001_ha->sas_addr, SAS_ADDR_SIZE);
>         payload.sas_identify.phy_id = phy_id;
> -       ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opcode, &payload,
> -                       sizeof(payload), 0);
> -       return ret;
> +
> +       return pm8001_mpi_build_cmd(pm8001_ha, 0, opcode, &payload,
> +                                   sizeof(payload), 0);
>  }
>
>  /**
> @@ -4365,17 +4344,15 @@ static int pm8001_chip_phy_stop_req(struct pm8001_hba_info *pm8001_ha,
>                                     u8 phy_id)
>  {
>         struct phy_stop_req payload;
> -       struct inbound_queue_table *circularQ;
> -       int ret;
>         u32 tag = 0x01;
>         u32 opcode = OPC_INB_PHYSTOP;
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
> +
>         memset(&payload, 0, sizeof(payload));
>         payload.tag = cpu_to_le32(tag);
>         payload.phy_id = cpu_to_le32(phy_id);
> -       ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opcode, &payload,
> -                       sizeof(payload), 0);
> -       return ret;
> +
> +       return pm8001_mpi_build_cmd(pm8001_ha, 0, opcode, &payload,
> +                                   sizeof(payload), 0);
>  }
>
>  /*
> @@ -4387,7 +4364,6 @@ static int pm8001_chip_reg_dev_req(struct pm8001_hba_info *pm8001_ha,
>         struct reg_dev_req payload;
>         u32     opc;
>         u32 stp_sspsmp_sata = 0x4;
> -       struct inbound_queue_table *circularQ;
>         u32 linkrate, phy_id;
>         int rc;
>         struct pm8001_ccb_info *ccb;
> @@ -4397,7 +4373,6 @@ static int pm8001_chip_reg_dev_req(struct pm8001_hba_info *pm8001_ha,
>         struct domain_device *dev = pm8001_dev->sas_device;
>         struct domain_device *parent_dev = dev->parent;
>         struct pm8001_port *port = dev->port->lldd_port;
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
>
>         memset(&payload, 0, sizeof(payload));
>         ccb = pm8001_ccb_alloc(pm8001_ha, pm8001_dev, NULL);
> @@ -4431,8 +4406,9 @@ static int pm8001_chip_reg_dev_req(struct pm8001_hba_info *pm8001_ha,
>                 cpu_to_le32(ITNT | (firstBurstSize * 0x10000));
>         memcpy(payload.sas_addr, pm8001_dev->sas_device->sas_addr,
>                 SAS_ADDR_SIZE);
> -       rc = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &payload,
> -                       sizeof(payload), 0);
> +
> +       rc = pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &payload,
> +                                 sizeof(payload), 0);
>         if (rc)
>                 pm8001_ccb_free(pm8001_ha, ccb);
>
> @@ -4447,18 +4423,15 @@ int pm8001_chip_dereg_dev_req(struct pm8001_hba_info *pm8001_ha,
>  {
>         struct dereg_dev_req payload;
>         u32 opc = OPC_INB_DEREG_DEV_HANDLE;
> -       int ret;
> -       struct inbound_queue_table *circularQ;
>
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
>         memset(&payload, 0, sizeof(payload));
>         payload.tag = cpu_to_le32(1);
>         payload.device_id = cpu_to_le32(device_id);
>         pm8001_dbg(pm8001_ha, MSG, "unregister device device_id = %d\n",
>                    device_id);
> -       ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &payload,
> -                       sizeof(payload), 0);
> -       return ret;
> +
> +       return pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &payload,
> +                                   sizeof(payload), 0);
>  }
>
>  /**
> @@ -4471,17 +4444,15 @@ static int pm8001_chip_phy_ctl_req(struct pm8001_hba_info *pm8001_ha,
>         u32 phyId, u32 phy_op)
>  {
>         struct local_phy_ctl_req payload;
> -       struct inbound_queue_table *circularQ;
> -       int ret;
>         u32 opc = OPC_INB_LOCAL_PHY_CONTROL;
> +
>         memset(&payload, 0, sizeof(payload));
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
>         payload.tag = cpu_to_le32(1);
>         payload.phyop_phyid =
>                 cpu_to_le32(((phy_op & 0xff) << 8) | (phyId & 0x0F));
> -       ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &payload,
> -                       sizeof(payload), 0);
> -       return ret;
> +
> +       return pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &payload,
> +                                   sizeof(payload), 0);
>  }
>
>  static u32 pm8001_chip_is_our_interrupt(struct pm8001_hba_info *pm8001_ha)
> @@ -4519,9 +4490,7 @@ static int send_task_abort(struct pm8001_hba_info *pm8001_ha, u32 opc,
>         u32 dev_id, u8 flag, u32 task_tag, u32 cmd_tag)
>  {
>         struct task_abort_req task_abort;
> -       struct inbound_queue_table *circularQ;
> -       int ret;
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
> +
>         memset(&task_abort, 0, sizeof(task_abort));
>         if (ABORT_SINGLE == (flag & ABORT_MASK)) {
>                 task_abort.abort_all = 0;
> @@ -4533,9 +4502,9 @@ static int send_task_abort(struct pm8001_hba_info *pm8001_ha, u32 opc,
>                 task_abort.device_id = cpu_to_le32(dev_id);
>                 task_abort.tag = cpu_to_le32(cmd_tag);
>         }
> -       ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &task_abort,
> -                       sizeof(task_abort), 0);
> -       return ret;
> +
> +       return pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &task_abort,
> +                                   sizeof(task_abort), 0);
>  }
>
>  /*
> @@ -4575,9 +4544,7 @@ int pm8001_chip_ssp_tm_req(struct pm8001_hba_info *pm8001_ha,
>         struct domain_device *dev = task->dev;
>         struct pm8001_device *pm8001_dev = dev->lldd_dev;
>         u32 opc = OPC_INB_SSPINITMSTART;
> -       struct inbound_queue_table *circularQ;
>         struct ssp_ini_tm_start_req sspTMCmd;
> -       int ret;
>
>         memset(&sspTMCmd, 0, sizeof(sspTMCmd));
>         sspTMCmd.device_id = cpu_to_le32(pm8001_dev->device_id);
> @@ -4587,10 +4554,9 @@ int pm8001_chip_ssp_tm_req(struct pm8001_hba_info *pm8001_ha,
>         sspTMCmd.tag = cpu_to_le32(ccb->ccb_tag);
>         if (pm8001_ha->chip_id != chip_8001)
>                 sspTMCmd.ds_ads_m = cpu_to_le32(0x08);
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
> -       ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &sspTMCmd,
> -                       sizeof(sspTMCmd), 0);
> -       return ret;
> +
> +       return pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &sspTMCmd,
> +                                   sizeof(sspTMCmd), 0);
>  }
>
>  int pm8001_chip_get_nvmd_req(struct pm8001_hba_info *pm8001_ha,
> @@ -4600,7 +4566,6 @@ int pm8001_chip_get_nvmd_req(struct pm8001_hba_info *pm8001_ha,
>         u32 nvmd_type;
>         int rc;
>         struct pm8001_ccb_info *ccb;
> -       struct inbound_queue_table *circularQ;
>         struct get_nvm_data_req nvmd_req;
>         struct fw_control_ex *fw_control_context;
>         struct pm8001_ioctl_payload *ioctl_payload = payload;
> @@ -4611,7 +4576,6 @@ int pm8001_chip_get_nvmd_req(struct pm8001_hba_info *pm8001_ha,
>                 return -ENOMEM;
>         fw_control_context->usrAddr = (u8 *)ioctl_payload->func_specific;
>         fw_control_context->len = ioctl_payload->rd_length;
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
>         memset(&nvmd_req, 0, sizeof(nvmd_req));
>
>         ccb = pm8001_ccb_alloc(pm8001_ha, NULL, NULL);
> @@ -4678,8 +4642,9 @@ int pm8001_chip_get_nvmd_req(struct pm8001_hba_info *pm8001_ha,
>         default:
>                 break;
>         }
> -       rc = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &nvmd_req,
> -                       sizeof(nvmd_req), 0);
> +
> +       rc = pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &nvmd_req,
> +                                 sizeof(nvmd_req), 0);
>         if (rc) {
>                 kfree(fw_control_context);
>                 pm8001_ccb_free(pm8001_ha, ccb);
> @@ -4694,7 +4659,6 @@ int pm8001_chip_set_nvmd_req(struct pm8001_hba_info *pm8001_ha,
>         u32 nvmd_type;
>         int rc;
>         struct pm8001_ccb_info *ccb;
> -       struct inbound_queue_table *circularQ;
>         struct set_nvm_data_req nvmd_req;
>         struct fw_control_ex *fw_control_context;
>         struct pm8001_ioctl_payload *ioctl_payload = payload;
> @@ -4703,7 +4667,7 @@ int pm8001_chip_set_nvmd_req(struct pm8001_hba_info *pm8001_ha,
>         fw_control_context = kzalloc(sizeof(struct fw_control_ex), GFP_KERNEL);
>         if (!fw_control_context)
>                 return -ENOMEM;
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
> +
>         memcpy(pm8001_ha->memoryMap.region[NVMD].virt_ptr,
>                 &ioctl_payload->func_specific,
>                 ioctl_payload->wr_length);
> @@ -4762,7 +4726,8 @@ int pm8001_chip_set_nvmd_req(struct pm8001_hba_info *pm8001_ha,
>         default:
>                 break;
>         }
> -       rc = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &nvmd_req,
> +
> +       rc = pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &nvmd_req,
>                         sizeof(nvmd_req), 0);
>         if (rc) {
>                 kfree(fw_control_context);
> @@ -4783,12 +4748,9 @@ pm8001_chip_fw_flash_update_build(struct pm8001_hba_info *pm8001_ha,
>  {
>         struct fw_flash_Update_req payload;
>         struct fw_flash_updata_info *info;
> -       struct inbound_queue_table *circularQ;
> -       int ret;
>         u32 opc = OPC_INB_FW_FLASH_UPDATE;
>
>         memset(&payload, 0, sizeof(struct fw_flash_Update_req));
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
>         info = fw_flash_updata_info;
>         payload.tag = cpu_to_le32(tag);
>         payload.cur_image_len = cpu_to_le32(info->cur_image_len);
> @@ -4799,9 +4761,9 @@ pm8001_chip_fw_flash_update_build(struct pm8001_hba_info *pm8001_ha,
>                 cpu_to_le32(lower_32_bits(le64_to_cpu(info->sgl.addr)));
>         payload.sgl_addr_hi =
>                 cpu_to_le32(upper_32_bits(le64_to_cpu(info->sgl.addr)));
> -       ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &payload,
> -                       sizeof(payload), 0);
> -       return ret;
> +
> +       return pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &payload,
> +                                   sizeof(payload), 0);
>  }
>
>  int
> @@ -4936,7 +4898,6 @@ pm8001_chip_set_dev_state_req(struct pm8001_hba_info *pm8001_ha,
>         struct pm8001_device *pm8001_dev, u32 state)
>  {
>         struct set_dev_state_req payload;
> -       struct inbound_queue_table *circularQ;
>         struct pm8001_ccb_info *ccb;
>         int rc;
>         u32 opc = OPC_INB_SET_DEVICE_STATE;
> @@ -4947,13 +4908,12 @@ pm8001_chip_set_dev_state_req(struct pm8001_hba_info *pm8001_ha,
>         if (!ccb)
>                 return -SAS_QUEUE_FULL;
>
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
>         payload.tag = cpu_to_le32(ccb->ccb_tag);
>         payload.device_id = cpu_to_le32(pm8001_dev->device_id);
>         payload.nds = cpu_to_le32(state);
>
> -       rc = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &payload,
> -                       sizeof(payload), 0);
> +       rc = pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &payload,
> +                                 sizeof(payload), 0);
>         if (rc)
>                 pm8001_ccb_free(pm8001_ha, ccb);
>
> @@ -4964,7 +4924,6 @@ static int
>  pm8001_chip_sas_re_initialization(struct pm8001_hba_info *pm8001_ha)
>  {
>         struct sas_re_initialization_req payload;
> -       struct inbound_queue_table *circularQ;
>         struct pm8001_ccb_info *ccb;
>         int rc;
>         u32 opc = OPC_INB_SAS_RE_INITIALIZE;
> @@ -4975,14 +4934,13 @@ pm8001_chip_sas_re_initialization(struct pm8001_hba_info *pm8001_ha)
>         if (!ccb)
>                 return -SAS_QUEUE_FULL;
>
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
>         payload.tag = cpu_to_le32(ccb->ccb_tag);
>         payload.SSAHOLT = cpu_to_le32(0xd << 25);
>         payload.sata_hol_tmo = cpu_to_le32(80);
>         payload.open_reject_cmdretries_data_retries = cpu_to_le32(0xff00ff);
>
> -       rc = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &payload,
> -                       sizeof(payload), 0);
> +       rc = pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &payload,
> +                                 sizeof(payload), 0);
>         if (rc)
>                 pm8001_ccb_free(pm8001_ha, ccb);
>
> diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
> index 824ada7f6a3f..aec4572906cf 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.h
> +++ b/drivers/scsi/pm8001/pm8001_sas.h
> @@ -668,8 +668,7 @@ int pm8001_mem_alloc(struct pci_dev *pdev, void **virt_addr,
>
>  void pm8001_chip_iounmap(struct pm8001_hba_info *pm8001_ha);
>  int pm8001_mpi_build_cmd(struct pm8001_hba_info *pm8001_ha,
> -                       struct inbound_queue_table *circularQ,
> -                       u32 opCode, void *payload, size_t nb,
> +                       u32 q_index, u32 opCode, void *payload, size_t nb,
>                         u32 responseQueue);
>  int pm8001_mpi_msg_free_get(struct inbound_queue_table *circularQ,
>                                 u16 messageSize, void **messagePtr);
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
> index 57ea933dab66..ce19aa361d26 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> @@ -1182,7 +1182,6 @@ int
>  pm80xx_set_thermal_config(struct pm8001_hba_info *pm8001_ha)
>  {
>         struct set_ctrl_cfg_req payload;
> -       struct inbound_queue_table *circularQ;
>         int rc;
>         u32 tag;
>         u32 opc = OPC_INB_SET_CONTROLLER_CONFIG;
> @@ -1193,7 +1192,6 @@ pm80xx_set_thermal_config(struct pm8001_hba_info *pm8001_ha)
>         if (rc)
>                 return rc;
>
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
>         payload.tag = cpu_to_le32(tag);
>
>         if (IS_SPCV_12G(pm8001_ha->pdev))
> @@ -1211,7 +1209,7 @@ pm80xx_set_thermal_config(struct pm8001_hba_info *pm8001_ha)
>                    "Setting up thermal config. cfg_pg 0 0x%x cfg_pg 1 0x%x\n",
>                    payload.cfg_pg[0], payload.cfg_pg[1]);
>
> -       rc = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &payload,
> +       rc = pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &payload,
>                         sizeof(payload), 0);
>         if (rc)
>                 pm8001_tag_free(pm8001_ha, tag);
> @@ -1228,7 +1226,6 @@ static int
>  pm80xx_set_sas_protocol_timer_config(struct pm8001_hba_info *pm8001_ha)
>  {
>         struct set_ctrl_cfg_req payload;
> -       struct inbound_queue_table *circularQ;
>         SASProtocolTimerConfig_t SASConfigPage;
>         int rc;
>         u32 tag;
> @@ -1238,11 +1235,9 @@ pm80xx_set_sas_protocol_timer_config(struct pm8001_hba_info *pm8001_ha)
>         memset(&SASConfigPage, 0, sizeof(SASProtocolTimerConfig_t));
>
>         rc = pm8001_tag_alloc(pm8001_ha, &tag);
> -
>         if (rc)
>                 return rc;
>
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
>         payload.tag = cpu_to_le32(tag);
>
>         SASConfigPage.pageCode = cpu_to_le32(SAS_PROTOCOL_TIMER_CONFIG_PAGE);
> @@ -1284,7 +1279,7 @@ pm80xx_set_sas_protocol_timer_config(struct pm8001_hba_info *pm8001_ha)
>         memcpy(&payload.cfg_pg, &SASConfigPage,
>                          sizeof(SASProtocolTimerConfig_t));
>
> -       rc = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &payload,
> +       rc = pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &payload,
>                         sizeof(payload), 0);
>         if (rc)
>                 pm8001_tag_free(pm8001_ha, tag);
> @@ -1390,7 +1385,6 @@ pm80xx_get_encrypt_info(struct pm8001_hba_info *pm8001_ha)
>  static int pm80xx_encrypt_update(struct pm8001_hba_info *pm8001_ha)
>  {
>         struct kek_mgmt_req payload;
> -       struct inbound_queue_table *circularQ;
>         int rc;
>         u32 tag;
>         u32 opc = OPC_INB_KEK_MANAGEMENT;
> @@ -1400,7 +1394,6 @@ static int pm80xx_encrypt_update(struct pm8001_hba_info *pm8001_ha)
>         if (rc)
>                 return rc;
>
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
>         payload.tag = cpu_to_le32(tag);
>         /* Currently only one key is used. New KEK index is 1.
>          * Current KEK index is 1. Store KEK to NVRAM is 1.
> @@ -1413,7 +1406,7 @@ static int pm80xx_encrypt_update(struct pm8001_hba_info *pm8001_ha)
>                    "Saving Encryption info to flash. payload 0x%x\n",
>                    le32_to_cpu(payload.new_curidx_ksop));
>
> -       rc = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &payload,
> +       rc = pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &payload,
>                         sizeof(payload), 0);
>         if (rc)
>                 pm8001_tag_free(pm8001_ha, tag);
> @@ -1770,7 +1763,6 @@ static void pm80xx_send_abort_all(struct pm8001_hba_info *pm8001_ha,
>         struct pm8001_ccb_info *ccb;
>         struct sas_task *task = NULL;
>         struct task_abort_req task_abort;
> -       struct inbound_queue_table *circularQ;
>         u32 opc = OPC_INB_SATA_ABORT;
>         int ret;
>
> @@ -1794,15 +1786,13 @@ static void pm80xx_send_abort_all(struct pm8001_hba_info *pm8001_ha,
>                 return;
>         }
>
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
> -
>         memset(&task_abort, 0, sizeof(task_abort));
>         task_abort.abort_all = cpu_to_le32(1);
>         task_abort.device_id = cpu_to_le32(pm8001_ha_dev->device_id);
>         task_abort.tag = cpu_to_le32(ccb->ccb_tag);
>
> -       ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &task_abort,
> -                       sizeof(task_abort), 0);
> +       ret = pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &task_abort,
> +                                  sizeof(task_abort), 0);
>         pm8001_dbg(pm8001_ha, FAIL, "Executing abort task end\n");
>         if (ret) {
>                 sas_free_task(task);
> @@ -1819,11 +1809,9 @@ static void pm80xx_send_read_log(struct pm8001_hba_info *pm8001_ha,
>         struct sas_task *task = NULL;
>         struct host_to_dev_fis fis;
>         struct domain_device *dev;
> -       struct inbound_queue_table *circularQ;
>         u32 opc = OPC_INB_SATA_HOST_OPSTART;
>
>         task = sas_alloc_slow_task(GFP_ATOMIC);
> -
>         if (!task) {
>                 pm8001_dbg(pm8001_ha, FAIL, "cannot allocate task !!!\n");
>                 return;
> @@ -1856,7 +1844,6 @@ static void pm80xx_send_read_log(struct pm8001_hba_info *pm8001_ha,
>         pm8001_ha_dev->id |= NCQ_2ND_RLE_FLAG;
>
>         memset(&sata_cmd, 0, sizeof(sata_cmd));
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
>
>         /* construct read log FIS */
>         memset(&fis, 0, sizeof(struct host_to_dev_fis));
> @@ -1871,8 +1858,8 @@ static void pm80xx_send_read_log(struct pm8001_hba_info *pm8001_ha,
>         sata_cmd.ncqtag_atap_dir_m_dad = cpu_to_le32(((0x1 << 7) | (0x5 << 9)));
>         memcpy(&sata_cmd.sata_fis, &fis, sizeof(struct host_to_dev_fis));
>
> -       res = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &sata_cmd,
> -                       sizeof(sata_cmd), 0);
> +       res = pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &sata_cmd,
> +                                  sizeof(sata_cmd), 0);
>         pm8001_dbg(pm8001_ha, FAIL, "Executing read log end\n");
>         if (res) {
>                 sas_free_task(task);
> @@ -3209,17 +3196,15 @@ static void pm80xx_hw_event_ack_req(struct pm8001_hba_info *pm8001_ha,
>         struct hw_event_ack_req  payload;
>         u32 opc = OPC_INB_SAS_HW_EVENT_ACK;
>
> -       struct inbound_queue_table *circularQ;
> -
>         memset((u8 *)&payload, 0, sizeof(payload));
> -       circularQ = &pm8001_ha->inbnd_q_tbl[Qnum];
>         payload.tag = cpu_to_le32(1);
>         payload.phyid_sea_portid = cpu_to_le32(((SEA & 0xFFFF) << 8) |
>                 ((phyId & 0xFF) << 24) | (port_id & 0xFF));
>         payload.param0 = cpu_to_le32(param0);
>         payload.param1 = cpu_to_le32(param1);
> -       pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &payload,
> -                       sizeof(payload), 0);
> +
> +       pm8001_mpi_build_cmd(pm8001_ha, Qnum, opc, &payload,
> +                            sizeof(payload), 0);
>  }
>
>  static int pm80xx_chip_phy_ctl_req(struct pm8001_hba_info *pm8001_ha,
> @@ -4198,7 +4183,6 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
>         u32 req_len, resp_len;
>         struct smp_req smp_cmd;
>         u32 opc;
> -       struct inbound_queue_table *circularQ;
>         u32 i, length;
>         u8 *payload;
>         u8 *to;
> @@ -4227,7 +4211,6 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
>         }
>
>         opc = OPC_INB_SMP_REQUEST;
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
>         smp_cmd.tag = cpu_to_le32(ccb->ccb_tag);
>
>         length = sg_req->length;
> @@ -4295,8 +4278,8 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
>         kunmap_atomic(to);
>         build_smp_cmd(pm8001_dev->device_id, smp_cmd.tag,
>                                 &smp_cmd, pm8001_ha->smp_exp_mode, length);
> -       rc = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &smp_cmd,
> -                       sizeof(smp_cmd), 0);
> +       rc = pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &smp_cmd,
> +                                 sizeof(smp_cmd), 0);
>         if (rc)
>                 goto err_out_2;
>         return 0;
> @@ -4356,10 +4339,8 @@ static int pm80xx_chip_ssp_io_req(struct pm8001_hba_info *pm8001_ha,
>         struct pm8001_device *pm8001_dev = dev->lldd_dev;
>         struct ssp_ini_io_start_req ssp_cmd;
>         u32 tag = ccb->ccb_tag;
> -       int ret;
>         u64 phys_addr, end_addr;
>         u32 end_addr_high, end_addr_low;
> -       struct inbound_queue_table *circularQ;
>         u32 q_index, cpu_id;
>         u32 opc = OPC_INB_SSPINIIOSTART;
>
> @@ -4383,7 +4364,6 @@ static int pm80xx_chip_ssp_io_req(struct pm8001_hba_info *pm8001_ha,
>                        task->ssp_task.cmd->cmd_len);
>         cpu_id = smp_processor_id();
>         q_index = (u32) (cpu_id) % (pm8001_ha->max_q_num);
> -       circularQ = &pm8001_ha->inbnd_q_tbl[q_index];
>
>         /* Check if encryption is set */
>         if (pm8001_ha->chip->encrypt &&
> @@ -4500,9 +4480,9 @@ static int pm80xx_chip_ssp_io_req(struct pm8001_hba_info *pm8001_ha,
>                         ssp_cmd.esgl = 0;
>                 }
>         }
> -       ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc,
> -                       &ssp_cmd, sizeof(ssp_cmd), q_index);
> -       return ret;
> +
> +       return pm8001_mpi_build_cmd(pm8001_ha, q_index, opc, &ssp_cmd,
> +                                   sizeof(ssp_cmd), q_index);
>  }
>
>  static int pm80xx_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
> @@ -4513,7 +4493,6 @@ static int pm80xx_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
>         struct pm8001_device *pm8001_ha_dev = dev->lldd_dev;
>         struct ata_queued_cmd *qc = task->uldd_task;
>         u32 tag = ccb->ccb_tag;
> -       int ret;
>         u32 q_index, cpu_id;
>         struct sata_start_req sata_cmd;
>         u32 hdr_tag, ncg_tag = 0;
> @@ -4521,13 +4500,11 @@ static int pm80xx_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
>         u32 end_addr_high, end_addr_low;
>         u32 ATAP = 0x0;
>         u32 dir;
> -       struct inbound_queue_table *circularQ;
>         unsigned long flags;
>         u32 opc = OPC_INB_SATA_HOST_OPSTART;
>         memset(&sata_cmd, 0, sizeof(sata_cmd));
>         cpu_id = smp_processor_id();
>         q_index = (u32) (cpu_id) % (pm8001_ha->max_q_num);
> -       circularQ = &pm8001_ha->inbnd_q_tbl[q_index];
>
>         if (task->data_dir == DMA_NONE && !task->ata_task.use_ncq) {
>                 ATAP = 0x04; /* no data*/
> @@ -4742,9 +4719,8 @@ static int pm80xx_chip_sata_req(struct pm8001_hba_info *pm8001_ha,
>                                 ccb->ccb_tag, opc,
>                                 qc ? qc->tf.command : 0, // ata opcode
>                                 ccb->device ? atomic_read(&ccb->device->running_req) : 0);
> -       ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc,
> -                       &sata_cmd, sizeof(sata_cmd), q_index);
> -       return ret;
> +       return pm8001_mpi_build_cmd(pm8001_ha, q_index, opc, &sata_cmd,
> +                                   sizeof(sata_cmd), q_index);
>  }
>
>  /**
> @@ -4756,11 +4732,9 @@ static int
>  pm80xx_chip_phy_start_req(struct pm8001_hba_info *pm8001_ha, u8 phy_id)
>  {
>         struct phy_start_req payload;
> -       struct inbound_queue_table *circularQ;
> -       int ret;
>         u32 tag = 0x01;
>         u32 opcode = OPC_INB_PHYSTART;
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
> +
>         memset(&payload, 0, sizeof(payload));
>         payload.tag = cpu_to_le32(tag);
>
> @@ -4782,9 +4756,9 @@ pm80xx_chip_phy_start_req(struct pm8001_hba_info *pm8001_ha, u8 phy_id)
>         memcpy(payload.sas_identify.sas_addr,
>           &pm8001_ha->sas_addr, SAS_ADDR_SIZE);
>         payload.sas_identify.phy_id = phy_id;
> -       ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opcode, &payload,
> -                       sizeof(payload), 0);
> -       return ret;
> +
> +       return pm8001_mpi_build_cmd(pm8001_ha, 0, opcode, &payload,
> +                                   sizeof(payload), 0);
>  }
>
>  /**
> @@ -4796,17 +4770,15 @@ static int pm80xx_chip_phy_stop_req(struct pm8001_hba_info *pm8001_ha,
>         u8 phy_id)
>  {
>         struct phy_stop_req payload;
> -       struct inbound_queue_table *circularQ;
> -       int ret;
>         u32 tag = 0x01;
>         u32 opcode = OPC_INB_PHYSTOP;
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
> +
>         memset(&payload, 0, sizeof(payload));
>         payload.tag = cpu_to_le32(tag);
>         payload.phy_id = cpu_to_le32(phy_id);
> -       ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opcode, &payload,
> -                       sizeof(payload), 0);
> -       return ret;
> +
> +       return pm8001_mpi_build_cmd(pm8001_ha, 0, opcode, &payload,
> +                                   sizeof(payload), 0);
>  }
>
>  /*
> @@ -4818,7 +4790,6 @@ static int pm80xx_chip_reg_dev_req(struct pm8001_hba_info *pm8001_ha,
>         struct reg_dev_req payload;
>         u32     opc;
>         u32 stp_sspsmp_sata = 0x4;
> -       struct inbound_queue_table *circularQ;
>         u32 linkrate, phy_id;
>         int rc;
>         struct pm8001_ccb_info *ccb;
> @@ -4828,7 +4799,6 @@ static int pm80xx_chip_reg_dev_req(struct pm8001_hba_info *pm8001_ha,
>         struct domain_device *dev = pm8001_dev->sas_device;
>         struct domain_device *parent_dev = dev->parent;
>         struct pm8001_port *port = dev->port->lldd_port;
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
>
>         memset(&payload, 0, sizeof(payload));
>         ccb = pm8001_ccb_alloc(pm8001_ha, pm8001_dev, NULL);
> @@ -4869,7 +4839,7 @@ static int pm80xx_chip_reg_dev_req(struct pm8001_hba_info *pm8001_ha,
>         memcpy(payload.sas_addr, pm8001_dev->sas_device->sas_addr,
>                 SAS_ADDR_SIZE);
>
> -       rc = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &payload,
> +       rc = pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &payload,
>                         sizeof(payload), 0);
>         if (rc)
>                 pm8001_ccb_free(pm8001_ha, ccb);
> @@ -4889,18 +4859,18 @@ static int pm80xx_chip_phy_ctl_req(struct pm8001_hba_info *pm8001_ha,
>         u32 tag;
>         int rc;
>         struct local_phy_ctl_req payload;
> -       struct inbound_queue_table *circularQ;
>         u32 opc = OPC_INB_LOCAL_PHY_CONTROL;
> +
>         memset(&payload, 0, sizeof(payload));
>         rc = pm8001_tag_alloc(pm8001_ha, &tag);
>         if (rc)
>                 return rc;
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
> +
>         payload.tag = cpu_to_le32(tag);
>         payload.phyop_phyid =
>                 cpu_to_le32(((phy_op & 0xFF) << 8) | (phyId & 0xFF));
>
> -       rc = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &payload,
> +       rc = pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &payload,
>                                   sizeof(payload), 0);
>         if (rc)
>                 pm8001_tag_free(pm8001_ha, tag);
> @@ -4946,7 +4916,6 @@ static void mpi_set_phy_profile_req(struct pm8001_hba_info *pm8001_ha,
>         u32 tag, i, j = 0;
>         int rc;
>         struct set_phy_profile_req payload;
> -       struct inbound_queue_table *circularQ;
>         u32 opc = OPC_INB_SET_PHY_PROFILE;
>
>         memset(&payload, 0, sizeof(payload));
> @@ -4956,7 +4925,6 @@ static void mpi_set_phy_profile_req(struct pm8001_hba_info *pm8001_ha,
>                 return;
>         }
>
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
>         payload.tag = cpu_to_le32(tag);
>         payload.ppc_phyid =
>                 cpu_to_le32(((operation & 0xF) << 8) | (phyid  & 0xFF));
> @@ -4967,8 +4935,8 @@ static void mpi_set_phy_profile_req(struct pm8001_hba_info *pm8001_ha,
>                 payload.reserved[j] = cpu_to_le32(*((u32 *)buf + i));
>                 j++;
>         }
> -       rc = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &payload,
> -                       sizeof(payload), 0);
> +       rc = pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &payload,
> +                                 sizeof(payload), 0);
>         if (rc)
>                 pm8001_tag_free(pm8001_ha, tag);
>  }
> @@ -4992,7 +4960,6 @@ void pm8001_set_phy_profile_single(struct pm8001_hba_info *pm8001_ha,
>         u32 tag, opc;
>         int rc, i;
>         struct set_phy_profile_req payload;
> -       struct inbound_queue_table *circularQ;
>
>         memset(&payload, 0, sizeof(payload));
>
> @@ -5002,7 +4969,6 @@ void pm8001_set_phy_profile_single(struct pm8001_hba_info *pm8001_ha,
>                 return;
>         }
>
> -       circularQ = &pm8001_ha->inbnd_q_tbl[0];
>         opc = OPC_INB_SET_PHY_PROFILE;
>
>         payload.tag = cpu_to_le32(tag);
> @@ -5013,7 +4979,7 @@ void pm8001_set_phy_profile_single(struct pm8001_hba_info *pm8001_ha,
>         for (i = 0; i < length; i++)
>                 payload.reserved[i] = cpu_to_le32(*(buf + i));
>
> -       rc = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &payload,
> +       rc = pm8001_mpi_build_cmd(pm8001_ha, 0, opc, &payload,
>                         sizeof(payload), 0);
>         if (rc)
>                 pm8001_tag_free(pm8001_ha, tag);
> --
> 2.34.1
>
