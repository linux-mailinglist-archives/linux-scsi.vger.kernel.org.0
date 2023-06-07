Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5597267E3
	for <lists+linux-scsi@lfdr.de>; Wed,  7 Jun 2023 20:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjFGSAQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 7 Jun 2023 14:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjFGSAP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 7 Jun 2023 14:00:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB741FDB;
        Wed,  7 Jun 2023 11:00:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 441C66396D;
        Wed,  7 Jun 2023 18:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B52C433EF;
        Wed,  7 Jun 2023 18:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686160812;
        bh=itM0kSXkj6+4/f+xa5PVjPgEfM6gGeCKb7f2+MUzyBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NouFUiyxEU814hiT29TpRKZjdun7PPHOw8DIiBTnIUh1ELmgGEQl5qQjaEku4+gyw
         C2BfGffb8S00rF+DcT70h/ljVQKEou61WOMA3Us5heF4d91eaM0LSrRyI4A/Zt0MrU
         4F1KHGqFd+ZCBaQcPwprCOtJLjQlAprPZAqzG9iI=
Date:   Wed, 7 Jun 2023 20:00:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ben Hutchings <benh@debian.org>
Cc:     Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-scsi <linux-scsi@vger.kernel.org>, security@kernel.org
Subject: Re: dpt_i2o fixes for stable
Message-ID: <2023060702-anemic-grinch-0d3e@gregkh>
References: <b1d71ba992d0adab2519dff17f6d241279c0f5f1.camel@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1d71ba992d0adab2519dff17f6d241279c0f5f1.camel@debian.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, May 27, 2023 at 10:42:00PM +0200, Ben Hutchings wrote:
> I'm proposing to address the most obvious issues with dpt_i2o on stable
> branches.  At this stage it may be better to remove it as has been done
> upstream, but I'd rather limit the regression for anyone still using
> the hardware.
> 
> The changes are:
> 
> - "scsi: dpt_i2o: Remove broken pass-through ioctl (I2OUSERCMD)",
>   which closes security flaws including CVE-2023-2007.
> - "scsi: dpt_i2o: Do not process completions with invalid addresses",
>   which removes the remaining bus_to_virt() call and may slightly
>   improve handling of misbehaving hardware.
> 
> These changes have been compiled on all the relevant stable branches,
> but I don't have hardware to test on.

All now queued up, thanks.

greg k-h
