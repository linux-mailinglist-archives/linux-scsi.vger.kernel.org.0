Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDF1C41A92
	for <lists+linux-scsi@lfdr.de>; Wed, 12 Jun 2019 05:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406911AbfFLDLN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 11 Jun 2019 23:11:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37622 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404957AbfFLDLM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 11 Jun 2019 23:11:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5C39MAp090974;
        Wed, 12 Jun 2019 03:10:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=ztQL/6JOMkgGRBjM3zGam37yYSs3aIO3BHdmtnesRJU=;
 b=vhKkRjsTu3Kn8WmF3uNTdEgVJjt1rxBU8zD/5FgBOUCP0fdQmjnDmsU6b1VjbY5bfzlg
 lpht4cm9srdO+dQSBByBW2yBbLRXK0iz4IAc2s7T61AL11x9QRoN46kMUH1Yrv7VXqga
 DzpXSq6VebMR6xm5oNRTxRESsVTqPvfmRPpLpj9Su74pVItmg2XBED+QYqMB6ZDLS94/
 I8VoDSh2yCCuPmsU3g6WN4+YS1bp9JhX3SvS5VOsHbDg5DYbaYCdbE8iw7nwA67+1KJ6
 AdXy3c2VXK1CjmiVNB+rT3gwzi6K+IZSQhRuacSwFHIbaNyDHNs51OwxxcRno3rHLNcQ 6w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2t05nqrktv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 03:10:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5C39408123405;
        Wed, 12 Jun 2019 03:10:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2t1jphse71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 03:10:01 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5C39s3G026872;
        Wed, 12 Jun 2019 03:09:57 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Jun 2019 20:09:54 -0700
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Ewan D. Milne" <emilne@redhat.com>, linux-scsi@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>,
        Cathy Avery <cavery@redhat.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH 2/5] scsi: advansys: use sg helper to operate sgl
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190610150317.29546-1-ming.lei@redhat.com>
        <20190610150317.29546-3-ming.lei@redhat.com>
        <1560191829.3698.8.camel@HansenPartnership.com>
        <ff5eba7c1ec7f5c6418c812ff24ac376d915188d.camel@redhat.com>
        <1560207747.3698.30.camel@HansenPartnership.com>
        <20190611002856.GA32621@ming.t460p> <yq1k1drfzrq.fsf@oracle.com>
        <20190612013930.GC17522@ming.t460p>
        <1560306453.20425.19.camel@HansenPartnership.com>
Date:   Tue, 11 Jun 2019 23:09:51 -0400
In-Reply-To: <1560306453.20425.19.camel@HansenPartnership.com> (James
        Bottomley's message of "Tue, 11 Jun 2019 19:27:33 -0700")
Message-ID: <yq1lfy7eby8.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906120019
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9285 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906120019
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


James,

> Studying the issue further, I think we have to do the rebase.  The
> problem is that any driver which hasn't been updated can be persuaded
> to walk of the end of the request and dereference the next struct
> request.  It's not impossible for userspace to set up both requests,
> so it looks like this could be used at least to leak information from
> the kernel if not exploit it outright.  I think that means we have to
> have every driver updated before this goes in.

I agree in theory. Although, regardless of ordering of the commits, this
would still be a single pull request for 5.3. So it's not like there
would be a kernel release with this flaw exposed. Assuming all drivers
get fixed.

Hence my concerns about breaking bisection. Not in terms of being able
to build, but in terms of being able to test intermediate commits on
systems with the affected drivers.

Ming: Please audit all drivers, including ones that live outside of
drivers/scsi but which use the midlayer such a s390, USB, libata,
etc. Just to make sure we've got all of them covered.

And then I think I'm inclined to reorder the 5.3 queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
