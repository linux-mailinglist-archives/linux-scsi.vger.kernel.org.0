Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5458E318EA3
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Feb 2021 16:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhBKPbQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Feb 2021 10:31:16 -0500
Received: from verein.lst.de ([213.95.11.211]:55824 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231220AbhBKP1F (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 11 Feb 2021 10:27:05 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 19B7B68C8C; Thu, 11 Feb 2021 16:14:51 +0100 (CET)
Date:   Thu, 11 Feb 2021 16:14:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hch@lst.de, loberman@redhat.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        mst@redhat.com, stefanha@redhat.com
Subject: Re: [PATCH 08/14] tcm_loop: Convert to new submission API
Message-ID: <20210211151450.GG22082@lst.de>
References: <20210211122728.31721-1-michael.christie@oracle.com> <20210211122728.31721-9-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211122728.31721-9-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Feb 11, 2021 at 06:27:22AM -0600, Mike Christie wrote:
> target_submit_cmd_map_sgls is being removed, so convert loop to
> the new submission API.
> 
> Even though loop does its own shutdown sync, this has loop use
> target_init_cmd/target_submit_prep/target_submit since it
> needed to map sgls and in the final patches it will use the
> API to use LIO's workqueue.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
