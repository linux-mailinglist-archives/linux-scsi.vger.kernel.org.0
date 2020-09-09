Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44B4262618
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Sep 2020 06:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgIIEKk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 9 Sep 2020 00:10:40 -0400
Received: from smtprelay0171.hostedemail.com ([216.40.44.171]:34126 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725300AbgIIEKk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 9 Sep 2020 00:10:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 0A2AF180A7FEE;
        Wed,  9 Sep 2020 04:10:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:4321:4605:5007:7807:8603:10007:10400:10848:11232:11658:11914:12043:12291:12297:12555:12683:12740:12760:12895:13069:13311:13357:13439:14096:14097:14659:14721:21080:21451:21627:21810:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: cars41_4c07f83270da
X-Filterd-Recvd-Size: 2198
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Wed,  9 Sep 2020 04:10:37 +0000 (UTC)
Message-ID: <0998cf5c4006b974b65ece9df1e782b840ff43cf.camel@perches.com>
Subject: Re: [PATCH 0/2] scsi: lpfc: Reduce logging object code size
From:   Joe Perches <joe@perches.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 08 Sep 2020 21:10:36 -0700
In-Reply-To: <cover.1597100152.git.joe@perches.com>
References: <cover.1597100152.git.joe@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 2020-08-10 at 15:59 -0700, Joe Perches wrote:
> The logging macros are pretty heavyweight and can be consolidated
> to reduce overall object size.
> 
> Joe Perches (2):
>   scsi: lpfc: Neaten logging macro #defines
>   scsi: lpfc: Add logging functions to reduce object size
> 
>  drivers/scsi/lpfc/Makefile       |   2 +-
>  drivers/scsi/lpfc/lpfc.h         |   5 ++
>  drivers/scsi/lpfc/lpfc_attr.h    |   5 ++
>  drivers/scsi/lpfc/lpfc_bsg.h     |   6 ++
>  drivers/scsi/lpfc/lpfc_compat.h  |   5 ++
>  drivers/scsi/lpfc/lpfc_crtn.h    |   5 ++
>  drivers/scsi/lpfc/lpfc_disc.h    |   5 ++
>  drivers/scsi/lpfc/lpfc_hw.h      |   5 ++
>  drivers/scsi/lpfc/lpfc_hw4.h     |   5 ++
>  drivers/scsi/lpfc/lpfc_ids.h     |   5 ++
>  drivers/scsi/lpfc/lpfc_logmsg.c  | 112 +++++++++++++++++++++++++++++++
>  drivers/scsi/lpfc/lpfc_logmsg.h  |  63 ++++++-----------
>  drivers/scsi/lpfc/lpfc_nl.h      |   4 ++
>  drivers/scsi/lpfc/lpfc_nvme.h    |   5 ++
>  drivers/scsi/lpfc/lpfc_scsi.h    |   4 ++
>  drivers/scsi/lpfc/lpfc_sli.h     |   5 ++
>  drivers/scsi/lpfc/lpfc_sli4.h    |   5 ++
>  drivers/scsi/lpfc/lpfc_version.h |   5 ++
>  18 files changed, 208 insertions(+), 43 deletions(-)
>  create mode 100644 drivers/scsi/lpfc/lpfc_logmsg.c

ping?


