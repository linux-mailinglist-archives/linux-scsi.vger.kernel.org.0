Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB84638B8A
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Jun 2019 15:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfFGNUs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 7 Jun 2019 09:20:48 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35772 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfFGNUr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 7 Jun 2019 09:20:47 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57DJCoc178668;
        Fri, 7 Jun 2019 13:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=6aO4FD7hnzZyA/SuYEhruVv4oczeFvgz+fkw0+uuRkw=;
 b=KR2CcoK2yckl9bFVZfINWh9m+Q3m92YHu1gtwPZJiFA8gC0LhtxGoeD0loyDE0bcoWkE
 u1JneG04FaI/JvFaW5iTYDK+CgdY46Wnbz6RBD1j0pk2SBkRrAwEJhF+uIUCEresEEEs
 6o+sxpsiZaY346s4jP6GBrDUswHIW6hSwvQprHVrWIfDV8gfmeggxsblHUDWp+QiZ6+P
 jOmxs/UlzCtErsoBjdPXk/cXwYWJCPTp23ESZq3hQs7pM8azrvqIJmOI9eyCfHVycaLM
 mqvd6dYfkBHkhtTSw10EiRL4NuLzRMLY82+vvJeOLZKwVPPujwLZWU4adaiMjBmtq/K8 RA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2suevdxg50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 13:20:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57DIhr0190689;
        Fri, 7 Jun 2019 13:20:18 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2swnhd8nq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 13:20:18 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x57DKDkp025862;
        Fri, 7 Jun 2019 13:20:13 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Jun 2019 06:20:12 -0700
To:     Don Brace <don.brace@microsemi.com>
Cc:     <Kevin.Barnett@microchip.com>, <scott.teel@microchip.com>,
        <Justin.Lindley@microchip.com>, <scott.benesh@microchip.com>,
        <bader.alisaleh@microchip.com>, <gerry.morong@microchip.com>,
        <mahesh.rajashekhara@microchip.com>, <hch@infradead.org>,
        <jejb@linux.vnet.ibm.com>, <joseph.szczypek@hpe.com>,
        <POSWALD@suse.com>, <shunyong.yang@hxt-semitech.com>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] hpsa: correct ioaccel2 chaining
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <155959820906.12441.16284446831021860511.stgit@brunhilda>
Date:   Fri, 07 Jun 2019 09:20:09 -0400
In-Reply-To: <155959820906.12441.16284446831021860511.stgit@brunhilda> (Don
        Brace's message of "Mon, 3 Jun 2019 16:43:29 -0500")
Message-ID: <yq1zhmtjzw6.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=663
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906070094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=713 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906070094
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Don,

> - set ioaccel2_sg_element member 'chain_indicator'
>   to IOACCEL2_LAST_SG for the last s/g element.
> - set ioaccel2_sg_element member 'chain_indicator'
>   to IOACCEL2_CHAIN when chaining.

Applied to 5.2/scsi-fixes, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
