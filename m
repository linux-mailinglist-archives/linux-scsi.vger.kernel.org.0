Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F89332203
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Mar 2021 10:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhCIJcc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 9 Mar 2021 04:32:32 -0500
Received: from verein.lst.de ([213.95.11.211]:59117 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229901AbhCIJcc (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 9 Mar 2021 04:32:32 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1B70868B05; Tue,  9 Mar 2021 10:32:27 +0100 (CET)
Date:   Tue, 9 Mar 2021 10:32:26 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Caleb Connolly <caleb@connolly.tech>
Cc:     Christoph Hellwig <hch@lst.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        ejb@linux.ibm.com, stanley.chu@mediatek.com, cang@codeaurora.org,
        beanhuo@micron.com, jaegeuk@kernel.org, asutoshd@codeaurora.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] scsi: ufshcd: switch to a version macro
Message-ID: <20210309093226.GA6320@lst.de>
References: <20210308005739.1998483-1-caleb@connolly.tech> <20210308005739.1998483-2-caleb@connolly.tech> <20210308080013.GE983@lst.de> <0c6cff2b-8d56-2b34-837d-b3d8f1fa5ad9@connolly.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c6cff2b-8d56-2b34-837d-b3d8f1fa5ad9@connolly.tech>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Mar 08, 2021 at 10:42:43AM +0000, Caleb Connolly wrote:
> >> +#define UFSHCI_VER(major, minor) \
> >> +	((major << 8) + (minor << 4))
> > This needs braces around major and minor.  Or better just convert it
> > to an inline function (and use a lower case name).
> 
> Other (similar) implementations, like NVME_VS() use a macro here, is an 
> inline function just personal preference?
> 
> I'm perfectly happy either way, so I'll switch to your suggestion.

In general inline functions are always preferred over non-trivial
macros.  Macros are required for a few cases where e.g. otherwise the
include dependencies would turn into a nightmare.
