Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6CC643C56
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Jun 2019 17:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbfFMPfV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 Jun 2019 11:35:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40692 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbfFMKZX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 13 Jun 2019 06:25:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5DAEIYU188848;
        Thu, 13 Jun 2019 10:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=FlLKK2CmsWq3FkbB9G88Bk5zDp2pwPWbamC0wr3NdLM=;
 b=aiWcOxJjJt/zIja22X4lJPuueJhmck61ySZcVqX99X/CRR8D6ODciS9GhgNr9PWWNfoA
 vSmEEJV6tYS65D38QSoXyQlu5o2NX90Wz//N9+Z/jQfE5IW13GmPbf+zt2abcNVDkf7g
 0NOfDspdJjHIp4xD1GQb4u80VAa7VW1qLc2bx2BecELQ5cmRwBIbl/BFHKA2V0IgamGD
 Gvi7vbVBkSJ2HqkygWXd4SwKe0pxIy+xLruSUZdqvlmx8q5Wlb35houd8bjep1aMoW5n
 aYfYoR0daU0BGwoYKbs2mLWWupAwpI0p0ZkHNrYMJ7J1ZhWXPcH9LRY8WaMhYt4HLcYY kw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2t05nr0kbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 10:24:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5DAMq9m153687;
        Thu, 13 Jun 2019 10:24:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2t1jpjfpqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 10:24:44 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5DAObQd008792;
        Thu, 13 Jun 2019 10:24:37 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Jun 2019 03:24:36 -0700
Date:   Thu, 13 Jun 2019 13:24:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        devel@driverdev.osuosl.org, Hannes Reinecke <hare@suse.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>, Jim Gill <jgill@vmware.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Brian King <brking@us.ibm.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        "Juergen E . Fischer" <fischer@norbit.de>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V2 08/15] staging: unisys: visorhba: use sg helper to
 operate sgl
Message-ID: <20190613102425.GB28859@kadam>
References: <20190613071335.5679-1-ming.lei@redhat.com>
 <20190613071335.5679-9-ming.lei@redhat.com>
 <20190613095214.GA18796@kroah.com>
 <20190613100410.GA10829@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613100410.GA10829@ming.t460p>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=949
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906130081
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=995 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906130081
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Jun 13, 2019 at 06:04:11PM +0800, Ming Lei wrote:
> On Thu, Jun 13, 2019 at 11:52:14AM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Jun 13, 2019 at 03:13:28PM +0800, Ming Lei wrote:
> > > The current way isn't safe for chained sgl, so use sg helper to
> > > operate sgl.
> > 
> > I can not make any sense out of this changelog.
> > 
> > What "isn't safe"?  What is a "sgl"?
> 
> sgl is 'scatterlist' in kernel, and several linear sgl can be chained
> together, so accessing the sgl in linear way may see a chained sg, which
> is like a link pointer, then may cause trouble for driver.
> 

So from a user perspective it results in an Oops?  It would be really
cool if you had the copy of the Oops btw so people could grep the git
history for it.

(You need to resend with the improved commit message).

regards,
dan carpenter

