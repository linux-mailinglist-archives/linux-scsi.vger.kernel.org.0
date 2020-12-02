Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6022CC235
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Dec 2020 17:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387434AbgLBQZy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Dec 2020 11:25:54 -0500
Received: from verein.lst.de ([213.95.11.211]:54904 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387405AbgLBQZy (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 2 Dec 2020 11:25:54 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BE87A68B02; Wed,  2 Dec 2020 17:25:12 +0100 (CET)
Date:   Wed, 2 Dec 2020 17:25:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 13/34] qla4xxx: use standard SAM status definitions
Message-ID: <20201202162512.GI32254@lst.de>
References: <20201202115249.37690-1-hare@suse.de> <20201202115249.37690-14-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202115249.37690-14-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
