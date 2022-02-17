Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9194BA9C4
	for <lists+linux-scsi@lfdr.de>; Thu, 17 Feb 2022 20:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245183AbiBQT23 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 17 Feb 2022 14:28:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245179AbiBQT22 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 17 Feb 2022 14:28:28 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93503104A41
        for <linux-scsi@vger.kernel.org>; Thu, 17 Feb 2022 11:28:13 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id p9so9650123ejd.6
        for <linux-scsi@vger.kernel.org>; Thu, 17 Feb 2022 11:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=10HKDw5FYCE+ccpMHzyzeaF9UkWtApo2vOUsl0v/Eg4=;
        b=G/wUgYfrysAOyMcCHzjqiZoBSXOjwTEkNXNTtMqEwT7huwD4aytn5KFIpFtzseRAzk
         uE+8QepzfRyre8ljEmJ3ozA9HWuUoZ9jQD8WAj0uwIYj8GJ7Cebgc6jnl9+vFX1+jLIE
         ELabHlU8coh3y5K3BCU2e1YkMfruZUXtWxkMxRVzJ9IfjQ84uVcfkPurYFHpJf1OLJvD
         bvuyinaohPP2lYLe7o2XXknNhfd81FJeBg2Y3yOn/lZfauaqGJH3yW0j1Q9XBconpVjj
         yZf4jDNIlVhOeu7+8xWjuq8Iwu+pEPNjd0rvDOca/Wk9SW4zej7OxYvnctbsWxT+HbWD
         bkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=10HKDw5FYCE+ccpMHzyzeaF9UkWtApo2vOUsl0v/Eg4=;
        b=ECcYKMUL+MqtqjeFmnamiCpaQWo96k/XvttG/ARoyGpuUH3JzFWXjSww+Gfk92z5lw
         UZsiLmruqVm28WPBnFhr7i34pPlh6w69e+FMQS4qW9Yxb2BXYCDDOjVHayy0J4MyWLF9
         /AWI/wNFDuzZMhK6UEBteGECeKjGUjJwutOJ7o9GugT449tzzKwpVTjib+RlvHcY7ZDo
         4slnvFbfTZbg249OPqm2Hb9GxmaMuiwERqrl6WzO0NaFp6Af56cVSV37bMmvbx6gxrK5
         gmpKSUjBFS7muxbH6TMpb18Iv9hG1lvplK7B93UpBgIwph5CaNUGO+DDbFeqmY6x3z8C
         1gyA==
X-Gm-Message-State: AOAM530k23/waSKz/AJXzYQxRp2h+K7oPJvv1QWO56m2PhmUPWSnrSco
        BXtXNzEJqjlSG8wpSYD3u46D2nAGLR+DAFHzM/51gQ==
X-Google-Smtp-Source: ABdhPJz4uKKtnWqFcQeAAYUDBB02t9ire2+3+Xx9AtgNMmVYN0mawtic+hLy+4EJYM/H2O50lmEK9AGI4y9JyBDT8FY=
X-Received: by 2002:a17:906:c299:b0:6b6:baa1:e5cb with SMTP id
 r25-20020a170906c29900b006b6baa1e5cbmr3551765ejz.624.1645126090718; Thu, 17
 Feb 2022 11:28:10 -0800 (PST)
MIME-Version: 1.0
References: <20220217132956.484818-1-damien.lemoal@opensource.wdc.com> <20220217132956.484818-16-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220217132956.484818-16-damien.lemoal@opensource.wdc.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 17 Feb 2022 20:28:00 +0100
Message-ID: <CAMGffEnvtvcoUznXuh2q2HbphzOPF=_rkEMWPRsMEn3t3ZAHUQ@mail.gmail.com>
Subject: Re: [PATCH v4 15/31] scsi: pm8001: Fix NCQ NON DATA command
 completion handling
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
> NCQ NON DATA is an NCQ command with the DMA_NONE DMA direction and so a
> register-device-to-host-FIS response is expected for it.
>
> However, for an IO_SUCCESS case, mpi_sata_completion() expects a
> set-device-bits-FIS for any ata task with an use_ncq field true, which
> includes NCQ NON DATA commands.
>
> Fix this to correctly treat NCQ NON DATA commands as non-data by also
> testing for the DMA_NONE DMA direction.
>
> Fixes: dbf9bfe61571 ("[SCSI] pm8001: add SAS/SATA HBA driver")
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
thx!
> ---
>  drivers/scsi/pm8001/pm8001_hwi.c | 3 ++-
>  drivers/scsi/pm8001/pm80xx_hwi.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
> index c0215a35a7b5..8149cc0d1ecd 100644
> --- a/drivers/scsi/pm8001/pm8001_hwi.c
> +++ b/drivers/scsi/pm8001/pm8001_hwi.c
> @@ -2415,7 +2415,8 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                                 len = sizeof(struct pio_setup_fis);
>                                 pm8001_dbg(pm8001_ha, IO,
>                                            "PIO read len = %d\n", len);
> -                       } else if (t->ata_task.use_ncq) {
> +                       } else if (t->ata_task.use_ncq &&
> +                                  t->data_dir != DMA_NONE) {
>                                 len = sizeof(struct set_dev_bits_fis);
>                                 pm8001_dbg(pm8001_ha, IO, "FPDMA len = %d\n",
>                                            len);
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
> index 3deb89b11d2f..ac2178a13e4c 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> @@ -2507,7 +2507,8 @@ mpi_sata_completion(struct pm8001_hba_info *pm8001_ha,
>                                 len = sizeof(struct pio_setup_fis);
>                                 pm8001_dbg(pm8001_ha, IO,
>                                            "PIO read len = %d\n", len);
> -                       } else if (t->ata_task.use_ncq) {
> +                       } else if (t->ata_task.use_ncq &&
> +                                  t->data_dir != DMA_NONE) {
>                                 len = sizeof(struct set_dev_bits_fis);
>                                 pm8001_dbg(pm8001_ha, IO, "FPDMA len = %d\n",
>                                            len);
> --
> 2.34.1
>
