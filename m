Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07BA310A28B
	for <lists+linux-scsi@lfdr.de>; Tue, 26 Nov 2019 17:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfKZQyo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 26 Nov 2019 11:54:44 -0500
Received: from verein.lst.de ([213.95.11.211]:41694 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728547AbfKZQyn (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 26 Nov 2019 11:54:43 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3D95E68C4E; Tue, 26 Nov 2019 17:54:42 +0100 (CET)
Date:   Tue, 26 Nov 2019 17:54:41 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Subject: Re: [PATCH 01/11] dpt_i2o: rename adpt_i2o_to_scsi() to
 adpt_i2o_scsi_complete()
Message-ID: <20191126165441.GC8204@lst.de>
References: <20191120103114.24723-1-hare@suse.de> <20191120103114.24723-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120103114.24723-2-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Nov 20, 2019 at 11:31:04AM +0100, Hannes Reinecke wrote:
> Rename the badly named function into adpt_i2o_scsi_complete(),
> and make it a void function as the return value is never used.
> This also fixes a potential use-after free as the return value
> might be evaluated from the command result after the command
> has been freed.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
