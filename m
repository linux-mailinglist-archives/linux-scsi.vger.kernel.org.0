Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 012FE10A2E8
	for <lists+linux-scsi@lfdr.de>; Tue, 26 Nov 2019 18:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbfKZRCk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 26 Nov 2019 12:02:40 -0500
Received: from verein.lst.de ([213.95.11.211]:41741 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727339AbfKZRCk (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 26 Nov 2019 12:02:40 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B651A68C4E; Tue, 26 Nov 2019 18:02:38 +0100 (CET)
Date:   Tue, 26 Nov 2019 18:02:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org,
        Balsundar P <balsundar.p@microsemi.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Subject: Re: [PATCH 05/11] aacraid: use midlayer helper to terminate
 outstanding commands
Message-ID: <20191126170238.GG8204@lst.de>
References: <20191120103114.24723-1-hare@suse.de> <20191120103114.24723-6-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120103114.24723-6-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
