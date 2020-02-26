Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C088170658
	for <lists+linux-scsi@lfdr.de>; Wed, 26 Feb 2020 18:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgBZRmI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 26 Feb 2020 12:42:08 -0500
Received: from verein.lst.de ([213.95.11.211]:50040 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgBZRmH (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 26 Feb 2020 12:42:07 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1EB5A68CEE; Wed, 26 Feb 2020 18:42:06 +0100 (CET)
Date:   Wed, 26 Feb 2020 18:42:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 07/13] aacraid: move scsi_(block,unblock)_requests out
 of _aac_reset_adapter()
Message-ID: <20200226174205.GD23141@lst.de>
References: <20200213140422.128382-1-hare@suse.de> <20200213140422.128382-8-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213140422.128382-8-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Feb 13, 2020 at 03:04:16PM +0100, Hannes Reinecke wrote:
> _aac_reset_adapter() only has one caller, and that one already calls
> scsi_block_requests(). So move the calls out of _aac_reset_adapter()
> to avoid calling scsi_block_requests() twice.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
