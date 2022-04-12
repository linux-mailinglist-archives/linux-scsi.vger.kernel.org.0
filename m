Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5312D4FEB0D
	for <lists+linux-scsi@lfdr.de>; Wed, 13 Apr 2022 01:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiDLXhU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 12 Apr 2022 19:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiDLXd2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 12 Apr 2022 19:33:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A78D35DE1
        for <linux-scsi@vger.kernel.org>; Tue, 12 Apr 2022 15:22:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34673B82050
        for <linux-scsi@vger.kernel.org>; Tue, 12 Apr 2022 21:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B529C385A5;
        Tue, 12 Apr 2022 21:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649798817;
        bh=ytnmiayIY3RwJ1hgpIJb47UfIVxZx6ozbY1Fe65+O74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YGaTjud++zSshCNMCOGyeaQRp4eGsNM5JfCtQbxUnKZjvyUIns/ADd0OJ+ruTkrkJ
         3mVimu6Z56Rl4cHcBqFYICCUMmWo9JgstAuXi2R/nnMxG6Cqk2o3bDCanlXOKm8ums
         jhEvTmlV6z1BsZpYwZ6lAMddX7MCNLkLMIB8VqRtb5lu0PtpuEarjQRrigCCAmY+Dn
         kbBbVff+ulPHLSXKkf476X+Fdqkw1UHc5nweHd7GznLBoPmjvPW6EMDPbSrswHv6oj
         xapB6hPflMFgR2p4qPWKj8/VB9s/lRSGOp6QItkSTw6HxShesJl+OB8bLlzbiudkGZ
         RRS46K7kVb+yA==
Date:   Tue, 12 Apr 2022 14:26:46 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-scsi@vger.kernel.org, Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Avri Altman <avri.altman@wdc.com>,
        Daejun Park <daejun7.park@samsung.com>
Subject: Re: [PATCH v2 07/29] scsi: ufs: Use get_unaligned_be16() instead of
 be16_to_cpup()
Message-ID: <YlXuliEBsVH0VPaP@sol.localdomain>
References: <20220412181853.3715080-1-bvanassche@acm.org>
 <20220412181853.3715080-8-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412181853.3715080-8-bvanassche@acm.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Apr 12, 2022 at 11:18:31AM -0700, Bart Van Assche wrote:
> Use get_unaligned_be16(...) instead of the equivalent but harder to read
> be16_to_cpup((__be16 *)...).
> 
> Reviewed-by: Bean Huo <beanhuo@micron.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/scsi/ufs/ufshcd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index d4ef31e1a409..3ec26c9eb1be 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -7334,7 +7334,7 @@ static u32 ufshcd_get_max_icc_level(int sup_curr_uA, u32 start_scan, char *buff)
>  	u16 unit;
>  
>  	for (i = start_scan; i >= 0; i--) {
> -		data = be16_to_cpup((__be16 *)&buff[2 * i]);
> +		data = get_unaligned_be16(&buff[2 * i]);

This is not "equivalent".  get_unaligned_be16() works on unaligned values
whereas be16_to_cpup() assumes a naturally aligned value.  This patch might
still be the right thing to do, but the explanation is not correct.

- Eric
