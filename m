Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBF55F075C
	for <lists+linux-scsi@lfdr.de>; Fri, 30 Sep 2022 11:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiI3JPt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 30 Sep 2022 05:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiI3JPs (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 30 Sep 2022 05:15:48 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F3665678
        for <linux-scsi@vger.kernel.org>; Fri, 30 Sep 2022 02:15:46 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id j24so4146741lja.4
        for <linux-scsi@vger.kernel.org>; Fri, 30 Sep 2022 02:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=mbCUi7iIwW+0leOB/DED62AZnjPutuu1M7qHobOoUY0=;
        b=b6Y+t900tkk8sCgvmxAKWfib14pmW7NpkkAn4LCccmwzs18wsekXHsCP1tEBed3fj7
         eLY7cvRh2gtvp0LDx7ITuxove/RTHoifW9Jtq1GWrj0ocRSe2p93ywKPJq1vyB0Ka1ZS
         cNBfUzaKDceAeQGeMnjaEXg1wPl5KaIg/jh+yaxsbVMAQyGngJY/DMXy1YeWsnaLV1m5
         9gc7Qc6m85+DtEPPBHZu+vhyZlXPp86SjW5REx0CIfWjYmFOrp7/4LGAofpojQRDDm9/
         zB2GQ0vUJUPKP/F1JUcHOCb4edk1GeNq38g9TcFZdgreLS03wNAiuA+Zni69YPTlbnou
         JDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mbCUi7iIwW+0leOB/DED62AZnjPutuu1M7qHobOoUY0=;
        b=NJ/JGItB6bbvzIGvjX1nH71tKrPph02t2l/NGBmbm5ymrwwp5aaLsQjcQb656GHTqC
         /d1VJJlEimlJkJAu7scy0tUmXfBCTdVrXwuq0xtQixCAA5MAsuihRgHZJa0QWknk+3K0
         xMTKHNuc2+cJg2Z/5g2Er/KA8635lT5MWrcnsusKgVEhLri5BtJo6I0jeD/7h6DK5Elv
         p+dXlmbQaq8xN7C/lQBwmCaGHOyb89gOA0oOLRZXQ9Sv1wzURdEDs2k3f1x5G3Rf5bbp
         kbLP0n1XNtFDQM9PY8KN3Mdfc1TsfJ+vW3BLHhkZQVXcU4P/NH/IGwOrDlQUkJPf1Axc
         KQPA==
X-Gm-Message-State: ACrzQf27EPDkyc3PdPg2du3hmjD94baAPzjcNrdKwKCa5hUJiHEISSYu
        82azrZBocAl3guXBmi5YmlYHLM2Oge0QB/HQF4eVMA==
X-Google-Smtp-Source: AMsMyM6yn6iTkJhXXc2P8mYh3w7Sajwdyn6q8vghlTMvAjkLMMVVO+n3jyw6LfO+HJwjTufywcXThjenoBhaX/phE8w=
X-Received: by 2002:a2e:a37a:0:b0:26d:8b41:9fe8 with SMTP id
 i26-20020a2ea37a000000b0026d8b419fe8mr2521993ljn.383.1664529344820; Fri, 30
 Sep 2022 02:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <1664528184-162714-1-git-send-email-john.garry@huawei.com> <1664528184-162714-2-git-send-email-john.garry@huawei.com>
In-Reply-To: <1664528184-162714-2-git-send-email-john.garry@huawei.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Fri, 30 Sep 2022 11:15:33 +0200
Message-ID: <CAMGffE=PtSczoDckYPFO4azsrVqqAaGgp6Upup8WVYhk=O4X7w@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] scsi: libsas: Add sas_task_find_rq()
To:     John Garry <john.garry@huawei.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        jinpu.wang@ionos.com, damien.lemoal@wdc.com, hare@suse.de,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, ipylypiv@google.com, changyuanl@google.com,
        hch@lst.de, yanaijie@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, Sep 30, 2022 at 11:03 AM John Garry <john.garry@huawei.com> wrote:
>
> blk-mq already provides a unique tag per request. Some libsas LLDDs - like
> hisi_sas - already use this tag as the unique per-IO HW tag.
>
> Add a common function to provide the request associated with a sas_task
> for all libsas LLDDs.
>
> Signed-off-by: John Garry <john.garry@huawei.com>
lgtm
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  include/scsi/libsas.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
> index f86b56bf7833..f498217961db 100644
> --- a/include/scsi/libsas.h
> +++ b/include/scsi/libsas.h
> @@ -644,6 +644,24 @@ static inline bool sas_is_internal_abort(struct sas_task *task)
>         return task->task_proto == SAS_PROTOCOL_INTERNAL_ABORT;
>  }
>
> +static inline struct request *sas_task_find_rq(struct sas_task *task)
> +{
> +       struct scsi_cmnd *scmd;
> +
> +       if (task->task_proto & SAS_PROTOCOL_STP_ALL) {
> +               struct ata_queued_cmd *qc = task->uldd_task;
> +
> +               scmd = qc ? qc->scsicmd : NULL;
> +       } else {
> +               scmd = task->uldd_task;
> +       }
> +
> +       if (!scmd)
> +               return NULL;
> +
> +       return scsi_cmd_to_rq(scmd);
> +}
> +
>  struct sas_domain_function_template {
>         /* The class calls these to notify the LLDD of an event. */
>         void (*lldd_port_formed)(struct asd_sas_phy *);
> --
> 2.35.3
>
