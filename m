Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BCE332950
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Mar 2021 15:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhCIOzv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 9 Mar 2021 09:55:51 -0500
Received: from verein.lst.de ([213.95.11.211]:60528 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230116AbhCIOzq (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 9 Mar 2021 09:55:46 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3459568B05; Tue,  9 Mar 2021 15:55:43 +0100 (CET)
Date:   Tue, 9 Mar 2021 15:55:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Caleb Connolly <caleb@connolly.tech>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        ejb@linux.ibm.com, stanley.chu@mediatek.com, cang@codeaurora.org,
        beanhuo@micron.com, jaegeuk@kernel.org, asutoshd@codeaurora.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RESEND PATCH v2 1/3] scsi: ufshcd: use a function to
 calculate versions
Message-ID: <20210309145543.GB14621@lst.de>
References: <20210309120212.119451-1-caleb@connolly.tech> <20210309120212.119451-2-caleb@connolly.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309120212.119451-2-caleb@connolly.tech>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Mar 09, 2021 at 12:02:47PM +0000, Caleb Connolly wrote:
> +static inline u32 ufshci_version(u32 major, u32 minor) {
> +	return (((major) << 8) + ((minor) << 4));
> +}

Kernel style puts the opening curly brace on a separate line.  Also
for an inline function adding parentheses is not required (unlike for
macros).

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
