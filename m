Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F681FD21B
	for <lists+linux-scsi@lfdr.de>; Wed, 17 Jun 2020 18:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgFQQ1b (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 17 Jun 2020 12:27:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbgFQQ1S (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 17 Jun 2020 12:27:18 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E5A521532;
        Wed, 17 Jun 2020 16:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592411238;
        bh=ScLhkw2jauAuFa+HO9GqJQWRwxRnGEdc0SoxSIILxtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bui2B2JPIpMHvAQczVEJ8hcWk7NL1RC/wtIniyXa4LGO3caxJk0SVQ7CO1LIJ3qXA
         FAs2SSTww29cXG2jr0bN+vlEW13gj73KY5Gt2O2wZv0lrG8y7iKfLbtBnRazoY2p+p
         3lOsWuuPyf26e6mR8dY9fFu2L39yv3uaXYvvMhGE=
Date:   Wed, 17 Jun 2020 09:27:16 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2/3] scsi: ufs: UFS crypto API
Message-ID: <20200617162716.GC1138@sol.localdomain>
References: <20200617081841.218985-1-satyat@google.com>
 <20200617081841.218985-3-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617081841.218985-3-satyat@google.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Jun 17, 2020 at 08:18:40AM +0000, Satya Tangirala wrote:
> Introduce functions to manipulate UFS inline encryption hardware
> in line with the JEDEC UFSHCI v2.1 specification and to work with the
> block keyslot manager.
> 
> The UFS crypto API will assume by default that a vendor driver doesn't
> support UFS crypto, even if the hardware advertises the capability, because
> a lot of hardware requires some special handling that's not specified in
> the aforementioned JEDEC spec. Each vendor driver must explicity set
> hba->caps |= UFSHCD_CAP_CRYPTO before ufshcd_hba_init_crypto is called to
> opt-in to UFS crypto support.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> Reviewed-by: Eric Biggers <ebiggers@google.com>

Stanley Chu had made a comment and provided Reviewed-by at
https://lkml.kernel.org/linux-scsi/1589524526.3197.110.camel@mtkswgap22.
Looks like that was missed?

- Eric
