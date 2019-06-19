Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7654C1D8
	for <lists+linux-scsi@lfdr.de>; Wed, 19 Jun 2019 21:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfFST4s (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 19 Jun 2019 15:56:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55546 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfFST4r (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 19 Jun 2019 15:56:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JJmvvv096125;
        Wed, 19 Jun 2019 19:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=Dx6Z35vdNa5nIMJSjGHBX/AyEwrPlmIse17O8d4CIes=;
 b=AFcKAjAZa98grkt8c2ZUAJ1rrBBeiPg99ObteAW/twZWxZVJCEXJHvfDzicV3j1F3I4d
 gfCfT7F4TXGH3m6l3c1Gf6WjZ/J+8tVdoRkuC8GzY5W4r/gTQjPs0Ph7Mj2vMhHr1KQW
 4XxP7fs5UIkBpYGWFWp7uLncYPf4QnCeeyIkylt/ULMQv6qetBhEulIaTeC/AhAlFR2F
 eqvmv0zurefeCZtAJJTMV9f49dcWUJMjYDvXPeNcMGZjuzD1cXOERwLJeD3uokqtQ4S7
 JgwGH0zUvICMS37SF0EzEPi0iA6cw33oD+C1nQJwOzOQrMh/3Mo/r9kmNlg6cFDp9iSM og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t7809dehk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 19:55:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JJtBMV111747;
        Wed, 19 Jun 2019 19:55:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2t77yn9p7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 19:55:52 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5JJte3f022148;
        Wed, 19 Jun 2019 19:55:40 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Jun 2019 12:55:39 -0700
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Jim Gill <jgill@vmware.com>,
        Cathy Avery <cavery@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Brian King <brking@us.ibm.com>,
        James Smart <james.smart@broadcom.com>,
        "Juergen E . Fischer" <fischer@norbit.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-usb@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Benjamin Block <bblock@linux.ibm.com>
Subject: Re: [PATCH V5 00/16] use sg helper to operate scatterlist
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190618013757.22401-1-ming.lei@redhat.com>
        <yq11rzqzacx.fsf@oracle.com>
        <3df71d64-78fb-c6fc-f456-a0b626abff3b@acm.org>
Date:   Wed, 19 Jun 2019 15:55:36 -0400
In-Reply-To: <3df71d64-78fb-c6fc-f456-a0b626abff3b@acm.org> (Bart Van Assche's
        message of "Wed, 19 Jun 2019 12:43:47 -0700")
Message-ID: <yq1wohhs62v.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190163
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Bart,

> Do you perhaps plan to push out these patches at a later time? It
> seems like that branch has not been updated recently:

I had a test failure on this end, that's why I didn't push. Appears to
be hardware-related, though. Still looking into it.

-- 
Martin K. Petersen	Oracle Linux Engineering
