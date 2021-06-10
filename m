Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA8C3A37CD
	for <lists+linux-scsi@lfdr.de>; Fri, 11 Jun 2021 01:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFJX1g (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 10 Jun 2021 19:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhFJX1g (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 10 Jun 2021 19:27:36 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4886BC061574;
        Thu, 10 Jun 2021 16:25:39 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 646B992009C; Fri, 11 Jun 2021 01:25:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 6070992009B;
        Fri, 11 Jun 2021 01:25:36 +0200 (CEST)
Date:   Fri, 11 Jun 2021 01:25:36 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Nix <nix@esperi.org.uk>, Khalid Aziz <khalid@gonehiking.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
cc:     Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PING][PATCH v2 0/5] Bring the BusLogic host bus adapter driver up
 to Y2021
In-Reply-To: <alpine.DEB.2.21.2104201934280.44318@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2106110102340.1657@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2104201934280.44318@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 20 Apr 2021, Maciej W. Rozycki wrote:

>  Questions, comments, concerns?  Otherwise please apply.

 Ping for: 

<https://patchwork.kernel.org/project/linux-scsi/list/?series=470455&archive=both>.

 Where are we with this patch series?  I can see it's been archived in 
patchwork in the new state.  With the unexpected serial device fixes which 
preempted me and which I've just posted, moving them off the table I now 
have some spare cycles to get back here, but I'm not sure what to do.

 Nix was kind enough to verify and tell me off-list that 5/5 still works 
correctly with his system that required the earlier change referred there 
and the need for which was not completely understood back then -- Nix, are 
you OK with adding a `Tested-by' tag for your verification?

 Otherwise is there anything I need to do to move forward with these 
changes?  Shall I just repost the series as it was given that it still 
applies to Linus master verbatim?

  Maciej
