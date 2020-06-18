Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22E31FEE0F
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Jun 2020 10:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgFRIr7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 18 Jun 2020 04:47:59 -0400
Received: from verein.lst.de ([213.95.11.211]:48057 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728579AbgFRIr7 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 18 Jun 2020 04:47:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8149768AFE; Thu, 18 Jun 2020 10:47:56 +0200 (CEST)
Date:   Thu, 18 Jun 2020 10:47:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Daniel Wagner <dwagner@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/4] gdth: reindent and whitespace cleanup
Message-ID: <20200618084756.GA2636@lst.de>
References: <20200616121821.99113-1-hare@suse.de> <20200616121821.99113-2-hare@suse.de> <20200617082145.mdsu56bclo3p3dg4@beryllium.lan> <2a7473b3-62af-f7d2-f73a-adcabe21701e@suse.de> <72827be0-a44a-0163-acb8-04ff3bde86ce@suse.de> <20200618081407.qsm4otp2w2bmcuil@beryllium.lan> <73b070da-2d27-d731-a8b2-b6a668524330@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73b070da-2d27-d731-a8b2-b6a668524330@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Do you actually have a gdth card?  Do we know of other users?
Maybe just dropping the driver might be a better option..
