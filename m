Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F283B579750
	for <lists+linux-scsi@lfdr.de>; Tue, 19 Jul 2022 12:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237340AbiGSKG4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 19 Jul 2022 06:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236984AbiGSKGz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 19 Jul 2022 06:06:55 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30429112B
        for <linux-scsi@vger.kernel.org>; Tue, 19 Jul 2022 03:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658225212; x=1689761212;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YauuOWB0eWlQxPIi0jYv3JHtwzs7d0w3Q3HbluMXv3M=;
  b=YfKKq2kdKKNah+D+8QqM5+b7vtgFzCu2oNahynr2Lm9IXgjiPCXPq8tV
   X0bZJE1ffbvhPlmaqsItkquwGSdu0EOdIZ9JG2ZKygNUZyfNh6IzC2fNy
   3U80nuvpT1fO1qmOx2knTnZi/eCdsInqiKONoSC+lY6GQflW7wTqm2T3+
   rPJlx+h1MuOOHXd+fUlNNSyMzswzMm9KWugLeMvMTIjwtjAcn9kEXNjJq
   dCj1aE9YhlZhe4gm/KCI0NrIuHgHfQrSh/Mda8gwRce/YlWJe2zxhLLHE
   Byg44Zj0YEqQ5GX1HcyIe0NJXhIu1GhJ63Q+j86dsSrk9igAHr9t54Gzg
   A==;
X-IronPort-AV: E=Sophos;i="5.92,283,1650902400"; 
   d="scan'208";a="211269523"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2022 18:06:52 +0800
IronPort-SDR: wA4IEKHEjWzDnkF3UE2Id+n1duSotiMSxfLgjnZlbpdXNZLkTEypa1Zrsfo1Zx0K9z/akZ+i3l
 SSWqMvH6ofKxt2YM1jksin9L1/P8brjzCVWRG5k8uE7aew1i1utHIiunsuZcOOAsFdxExBOsdS
 KwvLz8oGJuB4MGbe/3oVI9NWsFaEmmvn4OKrZXeAPHUBLxRI4tZy3MEAygBi1m/pyndRmyvBB1
 h60jXNWavRLetMg1X37jIsZe8xZHrsx1we7qSAIctjovYSqhBCAPgvCUBBte8NsHqnSSCyEpP0
 jwNzAs4I1dL7Zy7s90gj/G66
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jul 2022 02:23:20 -0700
IronPort-SDR: LkxS1R4ADoTyMtDOKo43QHzkKm/44HF5BESt27Wz3W66W3wZVm53M2khwUiGT+Tr3xB9zc3Wz0
 wghvMgtE0zPkFbV/y/R/GxtC2EhydYFnmVP+pYgs4wpvQGaX7nr3aLfCjsBiTylfl1KAMl6SLG
 eXhfpyxfnUWmwbSQ+f+Er0IZqKiiEQiE2NtfkRuJgXXWziTsjUTBRbTFHX5P1XZVQNsAuGEB4f
 bSyp9XxxepsNgolrB9N4lycoPO5Owk2HQvfhrYnPN5060yTk0241h/ogtZDjcNOcXVNbssZJ41
 zLs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jul 2022 03:06:53 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LnDyN4Mctz1Rwry
        for <linux-scsi@vger.kernel.org>; Tue, 19 Jul 2022 03:06:52 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658225212; x=1660817213; bh=YauuOWB0eWlQxPIi0jYv3JHtwzs7d0w3Q3H
        bluMXv3M=; b=B6ldBGGeutES4yTjwz6A5Ffl19zIhBlH1DbbBAoNmfheZbw0yji
        7chlMDHEzqOxzbOV8IWyRcJawMMqNI1g4VBqN0WWBc3WF4Gi1gyXJ2Pvl6+RwjAs
        Kyqya3ZHk/GjSbTU/ypiuMcOa/6rbZ1r/f/P4lsgF0Dt1563M0DLdwLuj6FwS0hY
        EUT6hs+JMHcmLOL5cJjzDJ1xSNbmQq5HeEWj0kvY1MnyQSnWiIhl0vWKOBbP2xob
        v8XBMFyZW/IiPq+iDVyfzApkD9rRrxE/8ckO3vQkJt+yvfVBSlphcjbEcZVV1xP1
        +FKXBj1Sil53riIbMkhuvMODRX/I5pEomIQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EwPUIUQFUlmV for <linux-scsi@vger.kernel.org>;
        Tue, 19 Jul 2022 03:06:52 -0700 (PDT)
Received: from [10.225.163.120] (unknown [10.225.163.120])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LnDyL6sYDz1RtVk;
        Tue, 19 Jul 2022 03:06:50 -0700 (PDT)
Message-ID: <af41fbeb-c2b1-e4c8-8b75-fa03fb9eb993@opensource.wdc.com>
Date:   Tue, 19 Jul 2022 19:06:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] scsi: sd: Add a comment about limiting max_sectors to
 shost optimal limit
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hch@lst.de
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
References: <1658224264-49972-1-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1658224264-49972-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 7/19/22 18:51, John Garry wrote:
> Add a comment about limiting the default the SCSI disk request_queue
> max_sectors initial value to that of the SCSI host optimal sectors limit.
> 
> Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 3eaee1f7aaca..ed9f43f9512e 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -3296,6 +3296,11 @@ static int sd_revalidate_disk(struct gendisk *disk)
>  				      (sector_t)BLK_DEF_MAX_SECTORS);
>  	}
>  
> +	/*
> +	 * Limit default to SCSI host optimal sector limit if set. There may be
> +	 * an impact on performance for when the size of a request exceeds this
> +	 * host limit.
> +	 */
>  	rw_max = min_not_zero(rw_max, sdp->host->opt_sectors);
>  
>  	/* Do not exceed controller limit */

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
