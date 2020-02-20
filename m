Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBE0166477
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Feb 2020 18:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgBTRXX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Feb 2020 12:23:23 -0500
Received: from verein.lst.de ([213.95.11.211]:50617 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728064AbgBTRXX (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 20 Feb 2020 12:23:23 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id A359A68BFE; Thu, 20 Feb 2020 18:23:20 +0100 (CET)
Date:   Thu, 20 Feb 2020 18:23:20 +0100
From:   'Christoph Hellwig' <hch@lst.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>,
        'Christoph Hellwig' <hch@lst.de>, linux-scsi@vger.kernel.org,
        'Alim Akhtar' <alim.akhtar@samsung.com>,
        'Avri Altman' <avri.altman@wdc.com>
Subject: Re: [PATCH 1/2] ufshcd: remove unused quirks
Message-ID: <20200220172320.GA14530@lst.de>
References: <20200218234450.69412-1-hch@lst.de> <CGME20200218234505epcas2p1ddd6db560233ff6aab1e1f0c30fd4eb2@epcas2p1.samsung.com> <20200218234450.69412-2-hch@lst.de> <0afd01d5e6b7$988cddf0$c9a699d0$@samsung.com> <20200219004248.GB213946@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219004248.GB213946@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Feb 18, 2020 at 04:42:49PM -0800, Eric Biggers wrote:
> These quirks have been there for 2-3 years without the driver that needs them
> even being posted to the mailing list since 2017.  Since we don't keep unused
> code in the upstream kernel, I support the removal of these quirks.  If you
> don't want them to be removed, you need to get your driver upstream.

Yes.  And some of them could be improved a little bit as well if they
get added back.  But given that this didn't happen in all the years I
do not mentally expect the driver to ever make it anyway.
