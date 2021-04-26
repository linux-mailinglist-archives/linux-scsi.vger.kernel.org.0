Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC8136B5BC
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Apr 2021 17:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbhDZP0H (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 26 Apr 2021 11:26:07 -0400
Received: from verein.lst.de ([213.95.11.211]:41792 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233919AbhDZP0G (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 26 Apr 2021 11:26:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D880668C7B; Mon, 26 Apr 2021 17:25:23 +0200 (CEST)
Date:   Mon, 26 Apr 2021 17:25:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Bart van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 18/39] dc395: translate message bytes
Message-ID: <20210426152522.GJ25615@lst.de>
References: <20210423113944.42672-1-hare@suse.de> <20210423113944.42672-19-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423113944.42672-19-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, Apr 23, 2021 at 01:39:23PM +0200, Hannes Reinecke wrote:
> Drop message byte setting if the host byte is already set, and
> translate message bytes into the related host bytes when evaluating
> an overrun or underrun.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
