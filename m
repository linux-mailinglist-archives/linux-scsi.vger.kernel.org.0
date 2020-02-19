Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 583941638A5
	for <lists+linux-scsi@lfdr.de>; Wed, 19 Feb 2020 01:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgBSAmv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Feb 2020 19:42:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:60550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgBSAmv (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 18 Feb 2020 19:42:51 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A782E24654;
        Wed, 19 Feb 2020 00:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582072970;
        bh=nlaeLL8xue00YFpb+IYOkigg6HcB3WAdxvf0CGGXDHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IPXaoMELi6V1+iB27IpdjCLWUtBak7s6ArLSgAKZN54tSiZ9hvw7yroPwI7bdmouG
         +O+ybdJNT0HEuGgarIkvO4aX7dM8M8vw43ilGjyM9+JUnZOChBncUmOYq6fxdzEu1N
         3zck1HxU3qetrKMF7l22R44sTg3+qL8WEjAcHZ6A=
Date:   Tue, 18 Feb 2020 16:42:49 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Kiwoong Kim <kwmad.kim@samsung.com>
Cc:     'Christoph Hellwig' <hch@lst.de>, linux-scsi@vger.kernel.org,
        'Alim Akhtar' <alim.akhtar@samsung.com>,
        'Avri Altman' <avri.altman@wdc.com>
Subject: Re: [PATCH 1/2] ufshcd: remove unused quirks
Message-ID: <20200219004248.GB213946@gmail.com>
References: <20200218234450.69412-1-hch@lst.de>
 <CGME20200218234505epcas2p1ddd6db560233ff6aab1e1f0c30fd4eb2@epcas2p1.samsung.com>
 <20200218234450.69412-2-hch@lst.de>
 <0afd01d5e6b7$988cddf0$c9a699d0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0afd01d5e6b7$988cddf0$c9a699d0$@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Feb 19, 2020 at 09:00:26AM +0900, Kiwoong Kim wrote:
> 
> Exynos specific driver sets and is using the following quirks but the driver
> is not updated
> yet. I'll do upstream it in the future.
> - UFSHCI_QUIRK_BROKEN_REQ_LIST_CLR
> - UFSHCD_QUIRK_PRDT_BYTE_GRAN
> - UFSHCI_QUIRK_SKIP_RESET_INTR_AGGR

These quirks have been there for 2-3 years without the driver that needs them
even being posted to the mailing list since 2017.  Since we don't keep unused
code in the upstream kernel, I support the removal of these quirks.  If you
don't want them to be removed, you need to get your driver upstream.

- Eric
