Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2AD70E268
	for <lists+linux-scsi@lfdr.de>; Tue, 23 May 2023 18:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237570AbjEWQjh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 23 May 2023 12:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbjEWQjg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 23 May 2023 12:39:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDA7DD
        for <linux-scsi@vger.kernel.org>; Tue, 23 May 2023 09:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684859976; x=1716395976;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EtJ8q9nhTAORQypI6s/XKvGnpoLA/3aitDj6vIsoqFY=;
  b=B8pxLdTAw9OSfbkt/bMv9quVQ2QslAManW1pGrBNzmcqcqDbAjZyn2tL
   H0F5I/hDCtAvjBq65SRAYpiUumOTsLiLiraTCD+DlvgTEFJS32H6QeFji
   Pn8i8jm7ckhhsQMDhaCosPyXcKF0/Vs9hHLfd114riRihiss81LBDoUHr
   AoLZYYDPNlhzo46VUZzgZG5JFwdWq9VbNSwPb2BdunuOmmZxbmrSLM5Zf
   dpyFsLXwWBbWywBIFNp+EGgKBLQNepHqQLj8AfL3EidSbb1qQ8wCiiul3
   O42NnE1HJR2RLPBS10qKlmqjwjbVYN2VozNZWfXL7/UGtxRkl9RwR+EWM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="337876859"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="337876859"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 09:39:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="828181860"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="828181860"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.39.37])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 09:39:32 -0700
Message-ID: <957fb6d6-83db-6230-d81c-646e12ed7bf1@intel.com>
Date:   Tue, 23 May 2023 19:39:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/4] scsi: ufs: Enable the BLK_MQ_F_BLOCKING flag
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20230517222359.1066918-1-bvanassche@acm.org>
 <20230517222359.1066918-4-bvanassche@acm.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230517222359.1066918-4-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 18/05/23 01:23, Bart Van Assche wrote:
> Prepare for adding code in ufshcd_queuecommand() that may sleep.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/ufs/core/ufshcd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 7ee150d67d49..993034ac1696 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -8756,6 +8756,7 @@ static const struct scsi_host_template ufshcd_driver_template = {
>  	.max_host_blocked	= 1,
>  	.track_queue_depth	= 1,
>  	.skip_settle_delay	= 1,
> +	.queuecommand_may_block = true,

Shouldn't this only be for controllers that support
clock gating?

>  	.sdev_groups		= ufshcd_driver_groups,
>  	.rpm_autosuspend_delay	= RPM_AUTOSUSPEND_DELAY_MS,
>  };
> 

