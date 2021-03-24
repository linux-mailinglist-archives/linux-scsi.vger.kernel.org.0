Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1C134722F
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Mar 2021 08:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhCXHOs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 24 Mar 2021 03:14:48 -0400
Received: from verein.lst.de ([213.95.11.211]:35712 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232018AbhCXHOq (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 24 Mar 2021 03:14:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7EB6368B02; Wed, 24 Mar 2021 08:14:44 +0100 (CET)
Date:   Wed, 24 Mar 2021 08:14:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     mwilck@suse.com
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, David Disseldorp <ddiss@suse.com>,
        =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v2 2/2] target: pscsi: cleanup after failure in
 pscsi_map_sg()
Message-ID: <20210324071444.GD647@lst.de>
References: <20210323212431.15306-1-mwilck@suse.com> <20210323212431.15306-2-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323212431.15306-2-mwilck@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Mar 23, 2021 at 10:24:31PM +0100, mwilck@suse.com wrote:
> From: Martin Wilck <mwilck@suse.com>
> 
> If pscsi_map_sg() fails, make sure to drop references to already
> allocated bios.
> 
> Signed-off-by: Martin Wilck <mwilck@suse.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
