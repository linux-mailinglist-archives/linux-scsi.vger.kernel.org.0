Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230055EEB7F
	for <lists+linux-scsi@lfdr.de>; Thu, 29 Sep 2022 04:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbiI2CNy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 28 Sep 2022 22:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbiI2CNu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 28 Sep 2022 22:13:50 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF311231CB
        for <linux-scsi@vger.kernel.org>; Wed, 28 Sep 2022 19:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664417616; x=1695953616;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zO7nZwjO+4icIzTbYvPkCSib8Umt5/wCg9niVHxMLlk=;
  b=jbqjKJbSWX1DQUFqHBuCbNM5sIiwysmCS/1ZC2zXaHZtFqUgHs+lAOho
   Y+RDR+llLNDmB69FpxgnuuWIXhqmwhAlpNAtxHV3nO8S3UqWLq5qVKd4B
   GrCa7UMjT5J2VkI9vGoMePRnsAtzhE73dUKmdofelDAmLSmi6yY6NjiP5
   lbTsl+NbJl1L9lgxZc2b7iQMrUoDBDv5vLFVK2wyyxa8mradWnbVQ7J4a
   jBhCamDfjHE48JfR0D6jCB0cTHd+ldbTZrgB+U+m2IdpbWMjjeyF6s9iK
   v4YnaPyq2yv7BRqcBzyU9bs3qgDRCqctBJUkWU1xASj1sYOXBI89KU2pF
   A==;
X-IronPort-AV: E=Sophos;i="5.93,353,1654531200"; 
   d="scan'208";a="217715652"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2022 10:13:21 +0800
IronPort-SDR: G9AYORYaYD6Tulpl8d7UceNItZm9h2Yzd9ELqkbyTWGQxXncDtJ4ex7BUtQnnTK+dWDqyVgTem
 WfniSlunSfov3uvj8muDgltp16G9yU160aLGTcSuf/PIb/oa3/0iaktFesuhR12HIxr2ECTkRH
 eKpjrpZgn45vOMeQyoCVAvnbYz1c9h6aEJ0pkibsYNSvShW/Gdn7d/JJLunStQjMrtwE6gd3YL
 n4d1r5esWODlyq5x07xyXmSXho+OeQeOpS/Kv5liNYEhYa8GGwxBQFRNOKxDspsbRB6DYpvDZI
 uqHcLnH4A0XBzPTDmRPeeNv/
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2022 18:27:44 -0700
IronPort-SDR: KzxdbnNbOxRSGyVu1HCxldIiQCq6WAnHajPF4MmOKxYEsZegtQyXrHUWcHGX5vm4cFJvoA4Nlb
 PTQ4sPw0oEeKlJRNBepgYcZO4+FsonzA96TY2b9igacXf4LyQlZx7RmpL73ssux1KNnHoiGSs8
 W9DZ6sDMe716aR3lm+12BorKRSBAOvSYHyxT3cqDsN0vws8svV7MElBXm/uS1D0GTKHGefK4ZU
 FU01il/iEq8wEyQTFdgo5KirPQecZ78gU2jMoDVqkJKsbjs9Ls3DyOZG+WqPiFH2XD6fdMsZaU
 RH0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2022 19:13:21 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MdH2m3d8gz1RwvL
        for <linux-scsi@vger.kernel.org>; Wed, 28 Sep 2022 19:13:20 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664417599; x=1667009600; bh=zO7nZwjO+4icIzTbYvPkCSib8Umt5/wCg9n
        iVHxMLlk=; b=eippMOJlvNt9a/oYKGcweuLpNIa2Tfj3QAdweFFp1BpnpC3/pqC
        A279Yy3Y3sSe32l40mZUaIyoP0JT0ZZZ91OmKEAzf2z5yo4i/Z/N60KCt2vYC/KO
        aCzbY/3iIQ5uXv4n0xDMnuxT8/b07h+JRjRD/MwRBcU03sOsvmtLhKw69nnvbXhu
        dehKy8uPhaeDVX74a/WGemLfk+Rq6f22yeFxZSUyjp5Sl0O30F/nN3LIrrPqWm8n
        gHp4wn4K0dCm3xy3DY1lcbT5m2gO3qoL0WhRuDs3v4qsOyUvQgsc8pxEVzGQZLt3
        En//iJWiiROTP6LqXJwHh1EBHQnKKjx8AeQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qkXdXN3vfjpU for <linux-scsi@vger.kernel.org>;
        Wed, 28 Sep 2022 19:13:19 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MdH2j6QtYz1RvLy;
        Wed, 28 Sep 2022 19:13:17 -0700 (PDT)
Message-ID: <8163fce3-5ecb-193d-bec7-abca704e9e07@opensource.wdc.com>
Date:   Thu, 29 Sep 2022 11:13:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 3/6] scsi: pm8001: Remove pm8001_tag_init()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, jinpu.wang@cloud.ionos.com
Cc:     hare@suse.de, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        ipylypiv@google.com, changyuanl@google.com, hch@lst.de
References: <1664368034-114991-1-git-send-email-john.garry@huawei.com>
 <1664368034-114991-4-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1664368034-114991-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 9/28/22 21:27, John Garry wrote:
> From: Igor Pylypiv <ipylypiv@google.com>
> 
> In commit 5a141315ed7c ("scsi: pm80xx: Increase the number of outstanding
> I/O supported to 1024") the pm8001_ha->tags allocation was moved into
> pm8001_init_ccb_tag(). This changed the execution order of allocation.
> pm8001_tag_init() used to be called after the pm8001_ha->tags allocation
> and now it is called before the allocation.
> 
> Before:
> 
> pm8001_pci_probe()
> `--> pm8001_pci_alloc()
>      `--> pm8001_alloc()
>           `--> pm8001_ha->tags = kzalloc(...)
>           `--> pm8001_tag_init(pm8001_ha); // OK: tags are allocated
> 
> After:
> 
> pm8001_pci_probe()
> `--> pm8001_pci_alloc()
> |    `--> pm8001_alloc()
> |         `--> pm8001_tag_init(pm8001_ha); // NOK: tags are not allocated
> |
> `--> pm8001_init_ccb_tag()
>      `-->  pm8001_ha->tags = kzalloc(...) // today it is bitmap_zalloc()
> 
> Since pm8001_ha->tags_num is zero when pm8001_tag_init() is called it does
> nothing. Tags memory is allocated with bitmap_zalloc() so there is no need
> to manually clear each bit with pm8001_tag_free().
> 
> Reviewed-by: Changyuan Lyu <changyuanl@google.com>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> Signed-off-by: John Garry <john.garry@huawei.com>

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/scsi/pm8001/pm8001_init.c | 2 --
>  drivers/scsi/pm8001/pm8001_sas.c  | 7 -------
>  drivers/scsi/pm8001/pm8001_sas.h  | 1 -
>  3 files changed, 10 deletions(-)
> 
> diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
> index a0028e130a7e..0edc9857a8bd 100644
> --- a/drivers/scsi/pm8001/pm8001_init.c
> +++ b/drivers/scsi/pm8001/pm8001_init.c
> @@ -436,8 +436,6 @@ static int pm8001_alloc(struct pm8001_hba_info *pm8001_ha,
>  		atomic_set(&pm8001_ha->devices[i].running_req, 0);
>  	}
>  	pm8001_ha->flags = PM8001F_INIT_TIME;
> -	/* Initialize tags */
> -	pm8001_tag_init(pm8001_ha);
>  	return 0;
>  
>  err_out_nodev:
> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
> index d5ec29f69be3..066dfa9f4683 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.c
> +++ b/drivers/scsi/pm8001/pm8001_sas.c
> @@ -96,13 +96,6 @@ int pm8001_tag_alloc(struct pm8001_hba_info *pm8001_ha, u32 *tag_out)
>  	return 0;
>  }
>  
> -void pm8001_tag_init(struct pm8001_hba_info *pm8001_ha)
> -{
> -	int i;
> -	for (i = 0; i < pm8001_ha->tags_num; ++i)
> -		pm8001_tag_free(pm8001_ha, i);
> -}
> -
>  /**
>   * pm8001_mem_alloc - allocate memory for pm8001.
>   * @pdev: pci device.
> diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
> index 8ab0654327f9..9acaadf02150 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.h
> +++ b/drivers/scsi/pm8001/pm8001_sas.h
> @@ -632,7 +632,6 @@ extern struct workqueue_struct *pm8001_wq;
>  
>  /******************** function prototype *********************/
>  int pm8001_tag_alloc(struct pm8001_hba_info *pm8001_ha, u32 *tag_out);
> -void pm8001_tag_init(struct pm8001_hba_info *pm8001_ha);
>  u32 pm8001_get_ncq_tag(struct sas_task *task, u32 *tag);
>  void pm8001_ccb_task_free(struct pm8001_hba_info *pm8001_ha,
>  			  struct pm8001_ccb_info *ccb);

-- 
Damien Le Moal
Western Digital Research

