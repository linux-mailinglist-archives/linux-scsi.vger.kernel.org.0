Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8F56170672
	for <lists+linux-scsi@lfdr.de>; Wed, 26 Feb 2020 18:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgBZRrR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 26 Feb 2020 12:47:17 -0500
Received: from verein.lst.de ([213.95.11.211]:50076 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbgBZRrR (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 26 Feb 2020 12:47:17 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7C15C68CEE; Wed, 26 Feb 2020 18:47:15 +0100 (CET)
Date:   Wed, 26 Feb 2020 18:47:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 13/13] scsi: Remove cmd_list functionality
Message-ID: <20200226174714.GJ23141@lst.de>
References: <20200213140422.128382-1-hare@suse.de> <20200213140422.128382-14-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213140422.128382-14-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Feb 13, 2020 at 03:04:22PM +0100, Hannes Reinecke wrote:
> Remove cmd_list functionality; no users left.
> With that the scsi_put_command() becomes empty,
> so remove that one, too.

Maybe use up all 73 chars for the commit message?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
