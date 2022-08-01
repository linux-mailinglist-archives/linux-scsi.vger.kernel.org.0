Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F0F5865C9
	for <lists+linux-scsi@lfdr.de>; Mon,  1 Aug 2022 09:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiHAHkk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 1 Aug 2022 03:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiHAHkj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 1 Aug 2022 03:40:39 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D3CB7F1
        for <linux-scsi@vger.kernel.org>; Mon,  1 Aug 2022 00:40:37 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id u9so12186116oiv.12
        for <linux-scsi@vger.kernel.org>; Mon, 01 Aug 2022 00:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=VMGRnrj3UJ0PORcKYl99d2dcQKIkMxTT9n9/QEBOg7w=;
        b=Xy5tBslx09C0Uazw3jQMWhvJFMyr+e4AvUxq8Mhe5VEUKxP7aYu/pO9QO11C8Dlge4
         JwavJQJMoJaZZQKlFABSOOMzLmyD6zBRgJB9i/b5e9aJyct98cTJDYCd1oybUSr8+9uD
         9HtfWPbt+xtUl/7htnrpxVVh6gOM4GEr+3Umc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VMGRnrj3UJ0PORcKYl99d2dcQKIkMxTT9n9/QEBOg7w=;
        b=hBFg0qxbsDfxNySsTIkVjO1yHKfiGh8EJsqMpmufJP+PG9h5ld2pp1Gu9AQxGa2u3A
         fhyKzN5pBW/PVh5PEOBLKQ1qDyyZzrA6awEOzOcjv1BJ7duVSOM6Q/pUePNC/H8xES4j
         HgCnS21xNT488aGPSetQoq62ypj60Vp2EcOCLr0PBPWT5QuFuGIuzWp64KlSPpRpoi2/
         8u8m+7RhUR5g+qYZ94gmyd7IizosVwS63rnlMQ7PhrLvyUXmWPyNmz7+oiLe2mj1jXAu
         YENNmWc7bzmvFv4DXqexJVIBO2Cxz5KW9ptbZfNv0qx96KpTDHd+qRp7QAq3ycp9MtKq
         S8PA==
X-Gm-Message-State: AJIora9WsQMDEBv5PhRi60wTB+1dL/Gnaq91NWbKCJJjzAC5HWqjoyds
        4NkFW6ehLiTozItMp9gIXVDyQP6rUU6xBmpO6bIPB4NfV3tOUQ==
X-Google-Smtp-Source: AGRyM1tALM8UimiXwrwKcc6gV50HeKq7A2LzqmMxbKATMMrcN7nr1gABA/nxWBDsXO/CFy1QSWoPMbojlRd2Wypki9c=
X-Received: by 2002:a05:6808:1447:b0:33d:e19e:f6eb with SMTP id
 x7-20020a056808144700b0033de19ef6ebmr3167907oiv.234.1659339636183; Mon, 01
 Aug 2022 00:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220729131627.15019-1-sreekanth.reddy@broadcom.com>
 <20220729131627.15019-3-sreekanth.reddy@broadcom.com> <AA2A58CA-8EB7-408B-AFE0-696E0BB04CE3@oracle.com>
In-Reply-To: <AA2A58CA-8EB7-408B-AFE0-696E0BB04CE3@oracle.com>
From:   Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Date:   Mon, 1 Aug 2022 13:10:25 +0530
Message-ID: <CAK=zhgrfjJT8AWOorn7yZVWLivoBfdd0Nn9gZ+Lbk23uHUOMYA@mail.gmail.com>
Subject: Re: [PATCH 02/15] mpi3mr: Add framework to issue cnfg requests
To:     Himanshu Madhani <himanshu.madhani@oracle.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Martin Petersen <martin.petersen@oracle.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000009b6fdb05e5291da8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--0000000000009b6fdb05e5291da8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 29, 2022 at 10:30 PM Himanshu Madhani
<himanshu.madhani@oracle.com> wrote:
>
>
>
> > On Jul 29, 2022, at 6:16 AM, Sreekanth Reddy <sreekanth.reddy@broadcom.=
com> wrote:
> >
> > Added framework to issue config requests commands to
> > controller firmware.
> >
> > Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> > ---
> > drivers/scsi/mpi3mr/mpi3mr.h    |  28 ++++
> > drivers/scsi/mpi3mr/mpi3mr_fw.c | 256 ++++++++++++++++++++++++++++++++
> > drivers/scsi/mpi3mr/mpi3mr_os.c |   1 +
> > 3 files changed, 285 insertions(+)
> >
> > diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.=
h
> > index 0935b2e..e15ad0e 100644
> > --- a/drivers/scsi/mpi3mr/mpi3mr.h
> > +++ b/drivers/scsi/mpi3mr/mpi3mr.h
> > @@ -97,6 +97,7 @@ extern atomic64_t event_counter;
> > #define MPI3MR_HOSTTAG_PEL_ABORT      3
> > #define MPI3MR_HOSTTAG_PEL_WAIT               4
> > #define MPI3MR_HOSTTAG_BLK_TMS                5
> > +#define MPI3MR_HOSTTAG_CFG_CMDS              6
> >
> > #define MPI3MR_NUM_DEVRMCMD           16
> > #define MPI3MR_HOSTTAG_DEVRMCMD_MIN   (MPI3MR_HOSTTAG_BLK_TMS + 1)
> > @@ -126,6 +127,8 @@ extern atomic64_t event_counter;
> >
> > #define MPI3MR_WATCHDOG_INTERVAL              1000 /* in milli seconds =
*/
> >
> > +#define MPI3MR_DEFAULT_CFG_PAGE_SZ           1024 /* in bytes */
> > +
> > #define MPI3MR_SCMD_TIMEOUT    (60 * HZ)
> > #define MPI3MR_EH_SCMD_TIMEOUT (60 * HZ)
> >
> > @@ -274,6 +277,7 @@ enum mpi3mr_reset_reason {
> >       MPI3MR_RESET_FROM_SYSFS =3D 23,
> >       MPI3MR_RESET_FROM_SYSFS_TIMEOUT =3D 24,
> >       MPI3MR_RESET_FROM_FIRMWARE =3D 27,
> > +     MPI3MR_RESET_FROM_CFG_REQ_TIMEOUT =3D 29,
> > };
> >
> > /* Queue type definitions */
> > @@ -679,6 +683,21 @@ struct mpi3mr_drv_cmd {
> >           struct mpi3mr_drv_cmd *drv_cmd);
> > };
> >
> > +/**
> > + * struct dma_memory_desc - memory descriptor structure to store
> > + * virtual address, dma address and size for any generic dma
> > + * memory allocations in the driver.
> > + *
> > + * @size: buffer size
> > + * @addr: virtual address
> > + * @dma_addr: dma address
> > + */
> > +struct dma_memory_desc {
> > +     u32 size;
> > +     void *addr;
> > +     dma_addr_t dma_addr;
> > +};
> > +
> >
> > /**
> >  * struct chain_element - memory descriptor structure to store
> > @@ -756,6 +775,7 @@ struct scmd_priv {
> >  * @num_op_reply_q: Number of operational reply queues
> >  * @op_reply_qinfo: Operational reply queue info pointer
> >  * @init_cmds: Command tracker for initialization commands
> > + * @cfg_cmds: Command tracker for configuration requests
> >  * @facts: Cached IOC facts data
> >  * @op_reply_desc_sz: Operational reply descriptor size
> >  * @num_reply_bufs: Number of reply buffers allocated
> > @@ -854,6 +874,9 @@ struct scmd_priv {
> >  * @io_throttle_low: I/O size to stop throttle in 512b blocks
> >  * @num_io_throttle_group: Maximum number of throttle groups
> >  * @throttle_groups: Pointer to throttle group info structures
> > + * @cfg_page: Default memory for configuration pages
> > + * @cfg_page_dma: Configuration page DMA address
> > + * @cfg_page_sz: Default configuration page memory size
> >  */
> > struct mpi3mr_ioc {
> >       struct list_head list;
> > @@ -904,6 +927,7 @@ struct mpi3mr_ioc {
> >       struct op_reply_qinfo *op_reply_qinfo;
> >
> >       struct mpi3mr_drv_cmd init_cmds;
> > +     struct mpi3mr_drv_cmd cfg_cmds;
> >       struct mpi3mr_ioc_facts facts;
> >       u16 op_reply_desc_sz;
> >
> > @@ -1025,6 +1049,10 @@ struct mpi3mr_ioc {
> >       u32 io_throttle_low;
> >       u16 num_io_throttle_group;
> >       struct mpi3mr_throttle_group_info *throttle_groups;
> > +
> > +     void *cfg_page;
> > +     dma_addr_t cfg_page_dma;
> > +     u16 cfg_page_sz;
> > };
> >
> > /**
> > diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3=
mr_fw.c
> > index 0866dfd..da6eceb 100644
> > --- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
> > +++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
> > @@ -299,6 +299,8 @@ mpi3mr_get_drv_cmd(struct mpi3mr_ioc *mrioc, u16 ho=
st_tag,
> >       switch (host_tag) {
> >       case MPI3MR_HOSTTAG_INITCMDS:
> >               return &mrioc->init_cmds;
> > +     case MPI3MR_HOSTTAG_CFG_CMDS:
> > +             return &mrioc->cfg_cmds;
> >       case MPI3MR_HOSTTAG_BSG_CMDS:
> >               return &mrioc->bsg_cmds;
> >       case MPI3MR_HOSTTAG_BLK_TMS:
> > @@ -907,6 +909,7 @@ static const struct {
> >       { MPI3MR_RESET_FROM_SYSFS, "sysfs invocation" },
> >       { MPI3MR_RESET_FROM_SYSFS_TIMEOUT, "sysfs TM timeout" },
> >       { MPI3MR_RESET_FROM_FIRMWARE, "firmware asynchronous reset" },
> > +     { MPI3MR_RESET_FROM_CFG_REQ_TIMEOUT, "configuration request timeo=
ut"},
> > };
> >
> > /**
> > @@ -3738,6 +3741,14 @@ retry_init:
> >
> >       mpi3mr_print_ioc_info(mrioc);
> >
> > +     dprint_init(mrioc, "allocating config page buffers\n");
> > +     mrioc->cfg_page =3D dma_alloc_coherent(&mrioc->pdev->dev,
> > +         MPI3MR_DEFAULT_CFG_PAGE_SZ, &mrioc->cfg_page_dma, GFP_KERNEL)=
;
> > +     if (!mrioc->cfg_page)
> > +             goto out_failed_noretry;
> > +
> > +     mrioc->cfg_page_sz =3D MPI3MR_DEFAULT_CFG_PAGE_SZ;
> > +
> >       retval =3D mpi3mr_alloc_reply_sense_bufs(mrioc);
> >       if (retval) {
> >               ioc_err(mrioc,
> > @@ -4362,6 +4373,10 @@ static void mpi3mr_flush_drv_cmds(struct mpi3mr_=
ioc *mrioc)
> >
> >       cmdptr =3D &mrioc->init_cmds;
> >       mpi3mr_drv_cmd_comp_reset(mrioc, cmdptr);
> > +
> > +     cmdptr =3D &mrioc->cfg_cmds;
> > +     mpi3mr_drv_cmd_comp_reset(mrioc, cmdptr);
> > +
> >       cmdptr =3D &mrioc->bsg_cmds;
> >       mpi3mr_drv_cmd_comp_reset(mrioc, cmdptr);
> >       cmdptr =3D &mrioc->host_tm_cmds;
> > @@ -4786,3 +4801,244 @@ out:
> >           ((retval =3D=3D 0) ? "successful" : "failed"));
> >       return retval;
> > }
> > +
> > +
> > +/**
> > + * mpi3mr_free_config_dma_memory - free memory for config page
> > + * @mrioc: Adapter instance reference
> > + * @mem_desc: memory descriptor structure
> > + *
> > + * Check whether the size of the buffer specified by the memory
> > + * descriptor is greater than the default page size if so then
> > + * free the memory pointed by the descriptor.
> > + *
> > + * Return: 0 on success, non-zero on failure.
>
> Nit: the above comment is incorrect. This function returns nothing.

Agree. Will update in the next patch version set.

>
> > + */
> > +static void mpi3mr_free_config_dma_memory(struct mpi3mr_ioc *mrioc,
> > +     struct dma_memory_desc *mem_desc)
> > +{
> > +     if ((mem_desc->size > mrioc->cfg_page_sz) && mem_desc->addr) {
> > +             dma_free_coherent(&mrioc->pdev->dev, mem_desc->size,
> > +                 mem_desc->addr, mem_desc->dma_addr);
> > +             mem_desc->addr =3D NULL;
> > +     }
> > +}
> > +
> > +
> > +
>
> Remove extra newline

Agree. Will remove it next patch version set.
>
> > +/**
> > + * mpi3mr_alloc_config_dma_memory - Alloc memory for config page
> > + * @mrioc: Adapter instance reference
> > + * @mem_desc: Memory descriptor to hold dma memory info
> > + *
> > + * This function allocates new dmaable memory or provides the
> > + * default config page dmaable memory based on the memory size
> > + * described by the descriptor.
> > + *
> > + * Return: 0 on success, non-zero on failure.
> > + */
> > +static int mpi3mr_alloc_config_dma_memory(struct mpi3mr_ioc *mrioc,
> > +     struct dma_memory_desc *mem_desc)
> > +{
> > +     if (mem_desc->size > mrioc->cfg_page_sz) {
> > +             mem_desc->addr =3D dma_alloc_coherent(&mrioc->pdev->dev,
> > +                 mem_desc->size, &mem_desc->dma_addr, GFP_KERNEL);
> > +             if (!mem_desc->addr)
> > +                     return -ENOMEM;
> > +     } else {
> > +             mem_desc->addr =3D mrioc->cfg_page;
> > +             mem_desc->dma_addr =3D mrioc->cfg_page_dma;
> > +             memset(mem_desc->addr, 0, mrioc->cfg_page_sz);
> > +     }
> > +     return 0;
> > +}
> > +
> > +
> > +/**
> > + * mpi3mr_post_cfg_req - Issue config requests and wait
> > + * @mrioc: Adapter instance reference
> > + * @cfg_req: Configuration request
> > + * @timeout: Timeout in seconds
> > + * @ioc_status: Pointer to return ioc status
> > + *
> > + * A generic function for posting MPI3 configuration request to
> > + * the firmware. This blocks for the completion of request for
> > + * timeout seconds and if the request times out this function
> > + * faults the controller with proper reason code.
> > + *
> > + * On successful completion of the request this function returns
> > + * appropriate ioc status from the firmware back to the caller.
> > + *
> > + * Return: 0 on success, non-zero on failure.
> > + */
> > +static int mpi3mr_post_cfg_req(struct mpi3mr_ioc *mrioc,
> > +     struct mpi3_config_request *cfg_req, int timeout, u16 *ioc_status=
)
> > +{
> > +     int retval =3D 0;
> > +
> > +     mutex_lock(&mrioc->cfg_cmds.mutex);
> > +     if (mrioc->cfg_cmds.state & MPI3MR_CMD_PENDING) {
> > +             retval =3D -1;
> > +             ioc_err(mrioc, "sending config request failed due to comm=
and in use\n");
> > +             mutex_unlock(&mrioc->cfg_cmds.mutex);
> > +             goto out;
> > +     }
> > +     mrioc->cfg_cmds.state =3D MPI3MR_CMD_PENDING;
> > +     mrioc->cfg_cmds.is_waiting =3D 1;
>
> You are setting is_waiting here, but I don=E2=80=99t see this being clear=
ed anywhere.

It is getting cleared in mpi3mr_process_admin_reply_desc() with below lines=
,

                        if (cmdptr->is_waiting) {
                                complete(&cmdptr->done);
                                cmdptr->is_waiting =3D 0;
                        } else if (cmdptr->callback)
                                cmdptr->callback(mrioc, cmdptr);

>
> > +     mrioc->cfg_cmds.callback =3D NULL;
> > +     mrioc->cfg_cmds.ioc_status =3D 0;
> > +     mrioc->cfg_cmds.ioc_loginfo =3D 0;
> > +
> > +     cfg_req->host_tag =3D cpu_to_le16(MPI3MR_HOSTTAG_CFG_CMDS);
> > +     cfg_req->function =3D MPI3_FUNCTION_CONFIG;
> > +
> > +     init_completion(&mrioc->cfg_cmds.done);
> > +     dprint_cfg_info(mrioc, "posting config request\n");
> > +     if (mrioc->logging_level & MPI3_DEBUG_CFG_INFO)
> > +             dprint_dump(cfg_req, sizeof(struct mpi3_config_request),
> > +                 "mpi3_cfg_req");
> > +     retval =3D mpi3mr_admin_request_post(mrioc, cfg_req, sizeof(*cfg_=
req), 1);
> > +     if (retval) {
> > +             ioc_err(mrioc, "posting config request failed\n");
> > +             goto out_unlock;
> > +     }
> > +     wait_for_completion_timeout(&mrioc->cfg_cmds.done, (timeout * HZ)=
);
> > +     if (!(mrioc->cfg_cmds.state & MPI3MR_CMD_COMPLETE)) {
> > +             mpi3mr_check_rh_fault_ioc(mrioc,
> > +                 MPI3MR_RESET_FROM_CFG_REQ_TIMEOUT);
> > +             ioc_err(mrioc, "config request timed out\n");
> > +             retval =3D -1;
> > +             goto out_unlock;
> > +     }
> > +     *ioc_status =3D mrioc->cfg_cmds.ioc_status & MPI3_IOCSTATUS_STATU=
S_MASK;
> > +     if ((*ioc_status) !=3D MPI3_IOCSTATUS_SUCCESS)
> > +             dprint_cfg_err(mrioc,
> > +                 "cfg_page request returned with ioc_status(0x%04x), l=
og_info(0x%08x)\n",
> > +                 *ioc_status, mrioc->cfg_cmds.ioc_loginfo);
> > +
> > +out_unlock:
> > +     mrioc->cfg_cmds.state =3D MPI3MR_CMD_NOTUSED;
>
> Should you not set mrioc->cfg_cmds.is_waiting =3D 0 here? Or am I missing=
 something?

cfg_cmds's is_waiting is cleared in mpi3mr_process_admin_reply_desc().

>
> > +     mutex_unlock(&mrioc->cfg_cmds.mutex);
> > +
> > +out:
> > +     return retval;
> > +}
> > +
> > +/**
> > + * mpi3mr_process_cfg_req - config page request processor
> > + * @mrioc: Adapter instance reference
> > + * @cfg_req: Configuration request
> > + * @cfg_hdr: Configuration page header
> > + * @timeout: Timeout in seconds
> > + * @ioc_status: Pointer to return ioc status
> > + * @cfg_buf: Memory pointer to copy config page or header
> > + * @cfg_buf_sz: Size of the memory to get config page or header
> > + *
> > + * This is handler for config page read, write and config page
> > + * header read operations.
> > + *
> > + * This function expects the cfg_req to be populated with page
> > + * type, page number, action for the header read and with page
> > + * address for all other operations.
> > + *
> > + * The cfg_hdr can be passed as null for reading required header
> > + * details for read/write pages the cfg_hdr should point valid
> > + * configuration page header.
> > + *
> > + * This allocates dmaable memory based on the size of the config
> > + * buffer and set the SGE of the cfg_req.
> > + *
> > + * For write actions, the config page data has to be passed in
> > + * the cfg_buf and size of the data has to be mentioned in the
> > + * cfg_buf_sz.
> > + *
> > + * For read/header actions, on successful completion of the
> > + * request with successful ioc_status the data will be copied
> > + * into the cfg_buf limited to a minimum of actual page size and
> > + * cfg_buf_sz
> > + *
> > + *
> > + * Return: 0 on success, non-zero on failure.
> > + */
> > +static int mpi3mr_process_cfg_req(struct mpi3mr_ioc *mrioc,
> > +     struct mpi3_config_request *cfg_req,
> > +     struct mpi3_config_page_header *cfg_hdr, int timeout, u16 *ioc_st=
atus,
> > +     void *cfg_buf, u32 cfg_buf_sz)
> > +{
> > +     struct dma_memory_desc mem_desc;
> > +     int retval =3D -1;
> > +     u8 invalid_action =3D 0;
> > +     u8 sgl_flags =3D MPI3MR_SGEFLAGS_SYSTEM_SIMPLE_END_OF_LIST;
> > +
> > +     memset(&mem_desc, 0, sizeof(struct dma_memory_desc));
> > +
> > +     if (cfg_req->action =3D=3D MPI3_CONFIG_ACTION_PAGE_HEADER)
> > +             mem_desc.size =3D sizeof(struct mpi3_config_page_header);
> > +     else {
> > +             if (!cfg_hdr) {
> > +                     ioc_err(mrioc, "null config header passed for con=
fig action(%d), page_type(0x%02x), page_num(%d)\n",
> > +                         cfg_req->action, cfg_req->page_type,
> > +                         cfg_req->page_number);
> > +                     goto out;
> > +             }
> > +             switch (cfg_hdr->page_attribute & MPI3_CONFIG_PAGEATTR_MA=
SK) {
> > +             case MPI3_CONFIG_PAGEATTR_READ_ONLY:
> > +                     if (cfg_req->action
> > +                         !=3D MPI3_CONFIG_ACTION_READ_CURRENT)
> > +                             invalid_action =3D 1;
> > +                     break;
> > +             case MPI3_CONFIG_PAGEATTR_CHANGEABLE:
> > +                     if ((cfg_req->action =3D=3D
> > +                          MPI3_CONFIG_ACTION_READ_PERSISTENT) ||
> > +                         (cfg_req->action =3D=3D
> > +                          MPI3_CONFIG_ACTION_WRITE_PERSISTENT))
> > +                             invalid_action =3D 1;
> > +                     break;
> > +             case MPI3_CONFIG_PAGEATTR_PERSISTENT:
> > +             default:
> > +                     break;
> > +             }
> > +             if (invalid_action) {
> > +                     ioc_err(mrioc,
> > +                         "config action(%d) is not allowed for page_ty=
pe(0x%02x), page_num(%d) with page_attribute(0x%02x)\n",
> > +                         cfg_req->action, cfg_req->page_type,
> > +                         cfg_req->page_number, cfg_hdr->page_attribute=
);
> > +                     goto out;
> > +             }
> > +             mem_desc.size =3D le16_to_cpu(cfg_hdr->page_length) * 4;
> > +             cfg_req->page_length =3D cfg_hdr->page_length;
> > +             cfg_req->page_version =3D cfg_hdr->page_version;
> > +     }
> > +     if (mpi3mr_alloc_config_dma_memory(mrioc, &mem_desc))
> > +             goto out;
> > +
> > +     mpi3mr_add_sg_single(&cfg_req->sgl, sgl_flags, mem_desc.size,
> > +         mem_desc.dma_addr);
> > +
> > +     if ((cfg_req->action =3D=3D MPI3_CONFIG_ACTION_WRITE_PERSISTENT) =
||
> > +         (cfg_req->action =3D=3D MPI3_CONFIG_ACTION_WRITE_CURRENT)) {
> > +             memcpy(mem_desc.addr, cfg_buf, min_t(u16, mem_desc.size,
> > +                 cfg_buf_sz));
> > +             dprint_cfg_info(mrioc, "config buffer to be written\n");
> > +             if (mrioc->logging_level & MPI3_DEBUG_CFG_INFO)
> > +                     dprint_dump(mem_desc.addr, mem_desc.size, "cfg_bu=
f");
> > +     }
> > +
> > +     if (mpi3mr_post_cfg_req(mrioc, cfg_req, timeout, ioc_status))
> > +             goto out;
> > +
> > +     retval =3D 0;
> > +     if ((*ioc_status =3D=3D MPI3_IOCSTATUS_SUCCESS) &&
> > +         (cfg_req->action !=3D MPI3_CONFIG_ACTION_WRITE_PERSISTENT) &&
> > +         (cfg_req->action !=3D MPI3_CONFIG_ACTION_WRITE_CURRENT)) {
> > +             memcpy(cfg_buf, mem_desc.addr, min_t(u16, mem_desc.size,
> > +                 cfg_buf_sz));
> > +             dprint_cfg_info(mrioc, "config buffer read\n");
> > +             if (mrioc->logging_level & MPI3_DEBUG_CFG_INFO)
> > +                     dprint_dump(mem_desc.addr, mem_desc.size, "cfg_bu=
f");
> > +     }
> > +
> > +out:
> > +     mpi3mr_free_config_dma_memory(mrioc, &mem_desc);
> > +     return retval;
> > +}
> > diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3=
mr_os.c
> > index 8bdf927..40bed22 100644
> > --- a/drivers/scsi/mpi3mr/mpi3mr_os.c
> > +++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
> > @@ -4574,6 +4574,7 @@ mpi3mr_probe(struct pci_dev *pdev, const struct p=
ci_device_id *id)
> >       mpi3mr_init_drv_cmd(&mrioc->init_cmds, MPI3MR_HOSTTAG_INITCMDS);
> >       mpi3mr_init_drv_cmd(&mrioc->host_tm_cmds, MPI3MR_HOSTTAG_BLK_TMS)=
;
> >       mpi3mr_init_drv_cmd(&mrioc->bsg_cmds, MPI3MR_HOSTTAG_BSG_CMDS);
> > +     mpi3mr_init_drv_cmd(&mrioc->cfg_cmds, MPI3MR_HOSTTAG_CFG_CMDS);
> >
> >       for (i =3D 0; i < MPI3MR_NUM_DEVRMCMD; i++)
> >               mpi3mr_init_drv_cmd(&mrioc->dev_rmhs_cmds[i],
> > --
> > 2.27.0
> >
>
> --
> Himanshu Madhani        Oracle Linux Engineering
>

--0000000000009b6fdb05e5291da8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
5AGo2E3pe+2yEgkxKvM2fnniZHUiSjbrfKk6nl9RIXPOKUP5HntZFdA5XuNYXWM+HPs3O0AJwBm/
VCZsZtkjVjxeBmTXiXDnxytdsHdGrHGymPfjJYatDu6d1KRVDlMCAwEAAaOCAd0wggHZMA4GA1Ud
DwEB/wQEAwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUu
Z2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggr
BgEFBQcwAYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3
Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4
aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmww
JwYDVR0RBCAwHoEcc3JlZWthbnRoLnJlZGR5QGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEF
BQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUClVHbAvhzGT8
s2/6xOf58NkGMQ8wDQYJKoZIhvcNAQELBQADggEBAENRsP1H3calKC2Sstg/8li8byKiqljCFkfi
IhcJsjPOOR9UZnMFxAoH/s2AlM7mQDR7rZ2MxRuUnIa6Cp5W5w1lUJHktjCUHnQq5nIAZ9GH5SDY
pgzbFsoYX8U2QCmkAC023FF++ZDJuc9aj0R/nhABxmUYErIze2jV/VO8Pj7TnCrBONZ/Qvf8G5CQ
X1hfOcCDBgT7eSvf9YRLaV935mB9/V+KYX8lT4E0lB4wQ0OLV8qUS9UuNoG2lCJ5UQTMrBgeUFFY
eKKhn+R91COmRlKGlaCdTtzKG5atS6dPnGEYUHjcpUvzejmJ5ghBk6P01HqSACsszDOzmBvdiOs+
Ux0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxyeqr1
0keLkvPdYw4wDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEID7eVKPZvd+4s1JCKznK
HrJbdf862Vwrw0Jxr2N/bUCfMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTIyMDgwMTA3NDAzNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQClfWKaLIcIot9kDqDwpg62S1PLJ+NIrGJMEsGy
KFYtngPBppLDAT/FyMKZOMzjm07yR9c5CmF65PKsiVBP1Fdv2UXIUuU6bBwl65PL5gmjiS5kXn/l
Xj6LaGLziC9NpEWKXHkbIrPAWDjQ85frrlzYsje5/nmTRk3qJ927yz/Xqp94B6+xuypIF03OEBLF
hhLBPjyCAe+GGy9LcTNniPAKGt6KjS1rKdP+lss9JU1wAUoeq6xOZt0i4Ws8LU6EVIW9leJ38qjf
zmpsztG46n/VRgwHs0qhKoe3jZndDHDEiRVfWej+2fbUjrsZDXXjXau+Fyvv6brqdndznRkuCVkP
--0000000000009b6fdb05e5291da8--
