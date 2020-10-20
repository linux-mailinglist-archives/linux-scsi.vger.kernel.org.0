Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71246288FDA
	for <lists+linux-scsi@lfdr.de>; Fri,  9 Oct 2020 19:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389529AbgJIROx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 9 Oct 2020 13:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732603AbgJIROx (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 9 Oct 2020 13:14:53 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139CCC0613D2
        for <linux-scsi@vger.kernel.org>; Fri,  9 Oct 2020 10:14:53 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o25so7710628pgm.0
        for <linux-scsi@vger.kernel.org>; Fri, 09 Oct 2020 10:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Vuf+3NHZS79/sBIBBOd+HW9OiSVjp8HSfR/2oIeyNY8=;
        b=cVrmltQKarF70z2+JrG5kxUV1wr3tgAPSgXAd+QhjIR+Xcfy1jhRYv8502WCzFMrtu
         pFnWtwVd7Iq4vhH2Cdhdf/6RnUOgKpplTPs53Qa8Gc22l+f3a5ifPCYkGKNb5u8Cf2by
         P5QzbtUGVjmwUwZNHKmxtWkGJqjuNA39W/RZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Vuf+3NHZS79/sBIBBOd+HW9OiSVjp8HSfR/2oIeyNY8=;
        b=UAOPGHRn6driczUsKJLnK5YioSSBMhzVAOGljb3G/bTixaR2f3bcy0GSLHj+5V37sj
         O6UnJ+mZ822U+/+fIHbjYg5sCl8BGkfClHMhew8yIP9P/eHh+flh5Nr+mSnD5yjkNQBz
         1HVY1yT3RWzHLmjvDOLMLfHsufVDUBfgkkYu2lBdAYgwikGW8u4xy6wP1xwSIAUebd6x
         51ZM6cMW1ZxOZxZY6/Zo1o//mB3yLCSuUf4654zBwlOpA2iflA6fnmagGen5gPQLlr7v
         3Rik8h96VLP9t+LQnkjgyEB7v88IVdeWp4N5lJM3ue3E4DlDW5tXinOR3JQKseQMoFf9
         iAKA==
X-Gm-Message-State: AOAM533mP3RrD6vxAOKWTYo9yRyn5fhayTMumbZNCxIyznC7myy+aZG3
        clJTjU5tWiOf0UHq+VJD6Nijbg==
X-Google-Smtp-Source: ABdhPJwujk+Vi4uzWmRn3HSKuo1xNC7mM2DjYh0pyfjxQqLZ26//5/yoZXE9c/6Uj0BDXUp5EK3nqQ==
X-Received: by 2002:a65:410c:: with SMTP id w12mr4162382pgp.411.1602263692345;
        Fri, 09 Oct 2020 10:14:52 -0700 (PDT)
Received: from dhcp-10-123-20-36.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id fy24sm12299055pjb.35.2020.10.09.10.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 10:14:51 -0700 (PDT)
From:   Sreekanth Reddy <sreekanth.reddy@broadcom.com>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, sathya.prakash@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Subject: [PATCH 13/14] mpt3sas: add module parameter multipath_on_hba
Date:   Fri,  9 Oct 2020 22:44:39 +0530
Message-Id: <20201009171440.4949-14-sreekanth.reddy@broadcom.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201009171440.4949-1-sreekanth.reddy@broadcom.com>
References: <20201009171440.4949-1-sreekanth.reddy@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000003fe85005b140164c"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--0000000000003fe85005b140164c

Add module parameter multipath_on_hba to enable/disable
the support a multi-port path topology.
By default this feature is enabled on SAS3.5 HBA device
and disabled on SAS3 &SAS2.5 HBA devices.

when this module parameter is disabled then driver uses
a default PhysicalPort(PortID) number i.e. 255 instead of
PhysicalPort number provided by HBA firmware.

Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.h      |  2 +
 drivers/scsi/mpt3sas/mpt3sas_ctl.c       |  6 ++-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c     | 69 ++++++++++++++++++++++--
 drivers/scsi/mpt3sas/mpt3sas_transport.c |  6 ++-
 4 files changed, 76 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index cca14ab..badd823 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -1246,6 +1246,7 @@ typedef void (*MPT3SAS_FLUSH_RUNNING_CMDS)(struct MPT3SAS_ADAPTER *ioc);
  *	which ensures the syncrhonization between cli/sysfs_show path.
  * @atomic_desc_capable: Atomic Request Descriptor support.
  * @GET_MSIX_INDEX: Get the msix index of high iops queues.
+ * @multipath_on_hba: flag to determine multipath on hba is enabled or not
  * @port_table_list: list containing HBA's wide/narrow port's info
  */
 struct MPT3SAS_ADAPTER {
@@ -1540,6 +1541,7 @@ struct MPT3SAS_ADAPTER {
 	PUT_SMID_DEFAULT put_smid_default;
 	GET_MSIX_INDEX get_msix_index_for_smlio;
 
+	u8		multipath_on_hba;
 	struct list_head port_table_list;
 };
 
diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index 5c32dbb..af2d3e3 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -902,8 +902,10 @@ _ctl_do_mpt_command(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command karg,
 		    (Mpi2SmpPassthroughRequest_t *)mpi_request;
 		u8 *data;
 
-		/* ioc determines which port to use */
-		smp_request->PhysicalPort = 0xFF;
+		if (!ioc->multipath_on_hba) {
+			/* ioc determines which port to use */
+			smp_request->PhysicalPort = 0xFF;
+		}
 		if (smp_request->PassthroughFlags &
 		    MPI2_SMP_PT_REQ_PT_FLAGS_IMMEDIATE)
 			data = (u8 *)&smp_request->SGL;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index da4ffa6..699fc9a 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -159,6 +159,15 @@ module_param(enable_sdev_max_qd, bool, 0444);
 MODULE_PARM_DESC(enable_sdev_max_qd,
 	"Enable sdev max qd as can_queue, def=disabled(0)");
 
+static int multipath_on_hba = -1;
+module_param(multipath_on_hba, int, 0);
+MODULE_PARM_DESC(multipath_on_hba,
+	"Multipath support to add same target device\n\t\t"
+	"as many times as it is visible to HBA from various paths\n\t\t"
+	"(by default:\n\t\t"
+	"\t SAS 2.0 & SAS 3.0 HBA - This will be disabled,\n\t\t"
+	"\t SAS 3.5 HBA - This will be enabled)");
+
 /* raid transport support */
 static struct raid_template *mpt3sas_raid_template;
 static struct raid_template *mpt2sas_raid_template;
@@ -373,6 +382,14 @@ mpt3sas_get_port_by_id(struct MPT3SAS_ADAPTER *ioc,
 {
 	struct hba_port *port, *port_next;
 
+	/*
+	 * When multipath_on_hba is disabled then
+	 * search the hba_port entry using default
+	 * port id i.e. 255
+	 */
+	if (!ioc->multipath_on_hba)
+		port_id = MULTIPATH_DISABLED_PORT_ID;
+
 	list_for_each_entry_safe(port, port_next,
 	    &ioc->port_table_list, list) {
 		if (port->port_id != port_id)
@@ -384,6 +401,24 @@ mpt3sas_get_port_by_id(struct MPT3SAS_ADAPTER *ioc,
 		return port;
 	}
 
+	/*
+	 * Allocate hba_port object for default port id (i.e. 255)
+	 * when multipath_on_hba is disabled for the HBA.
+	 * And add this object to port_table_list.
+	 */
+	if (!ioc->multipath_on_hba) {
+		port = kzalloc(sizeof(struct hba_port), GFP_KERNEL);
+		if (!port)
+			return NULL;
+
+		port->port_id = port_id;
+		ioc_info(ioc,
+		   "hba_port entry: %p, port: %d is added to hba_port list\n",
+		   port, port->port_id);
+		list_add_tail(&port->list,
+		    &ioc->port_table_list);
+		return port;
+	}
 	return NULL;
 }
 
@@ -10013,6 +10048,7 @@ _scsih_search_responding_expanders(struct MPT3SAS_ADAPTER *ioc)
 	u16 ioc_status;
 	u64 sas_address;
 	u16 handle;
+	u8 port;
 
 	ioc_info(ioc, "search for expanders: start\n");
 
@@ -10030,10 +10066,12 @@ _scsih_search_responding_expanders(struct MPT3SAS_ADAPTER *ioc)
 
 		handle = le16_to_cpu(expander_pg0.DevHandle);
 		sas_address = le64_to_cpu(expander_pg0.SASAddress);
+		port = expander_pg0.PhysicalPort;
 		pr_info(
 		    "\texpander present: handle(0x%04x), sas_addr(0x%016llx), port:%d\n",
 		    handle, (unsigned long long)sas_address,
-		    expander_pg0.PhysicalPort);
+		    (ioc->multipath_on_hba ?
+		    port : MULTIPATH_DISABLED_PORT_ID));
 		_scsih_mark_responding_expander(ioc, &expander_pg0);
 	}
 
@@ -10476,8 +10514,10 @@ mpt3sas_scsih_reset_done_handler(struct MPT3SAS_ADAPTER *ioc)
 	dtmprintk(ioc, ioc_info(ioc, "%s: MPT3_IOC_DONE_RESET\n", __func__));
 	if ((!ioc->is_driver_loading) && !(disable_discovery > 0 &&
 					   !ioc->sas_hba.num_phys)) {
-		_scsih_sas_port_refresh(ioc);
-		_scsih_update_vphys_after_reset(ioc);
+		if (ioc->multipath_on_hba) {
+			_scsih_sas_port_refresh(ioc);
+			_scsih_update_vphys_after_reset(ioc);
+		}
 		_scsih_prep_device_scan(ioc);
 		_scsih_create_enclosure_list_after_reset(ioc);
 		_scsih_search_responding_sas_devices(ioc);
@@ -11765,6 +11805,12 @@ _scsih_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			ioc->mfg_pg10_hide_flag = MFG_PAGE10_EXPOSE_ALL_DISKS;
 			break;
 		}
+
+		if (multipath_on_hba == -1 || multipath_on_hba == 0)
+			ioc->multipath_on_hba = 0;
+		else
+			ioc->multipath_on_hba = 1;
+
 		break;
 	case MPI25_VERSION:
 	case MPI26_VERSION:
@@ -11826,6 +11872,23 @@ _scsih_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 				ioc->combined_reply_index_count =
 				 MPT3_SUP_REPLY_POST_HOST_INDEX_REG_COUNT_G3;
 		}
+
+		switch (ioc->is_gen35_ioc) {
+		case 0:
+			if (multipath_on_hba == -1 || multipath_on_hba == 0)
+				ioc->multipath_on_hba = 0;
+			else
+				ioc->multipath_on_hba = 1;
+			break;
+		case 1:
+			if (multipath_on_hba == -1 || multipath_on_hba > 0)
+				ioc->multipath_on_hba = 1;
+			else
+				ioc->multipath_on_hba = 0;
+		default:
+			break;
+		}
+
 		break;
 	default:
 		return -ENODEV;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3sas/mpt3sas_transport.c
index 0d06025..6f47082 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
@@ -912,7 +912,8 @@ mpt3sas_transport_port_remove(struct MPT3SAS_ADAPTER *ioc, u64 sas_address,
 		return;
 	}
 
-	if (sas_node->handle <= ioc->sas_hba.num_phys) {
+	if (sas_node->handle <= ioc->sas_hba.num_phys &&
+	    (ioc->multipath_on_hba)) {
 		if (port->vphys_mask) {
 			list_for_each_entry_safe(vphy, vphy_next,
 			    &port->vphys_list, list) {
@@ -1172,7 +1173,8 @@ mpt3sas_transport_update_links(struct MPT3SAS_ADAPTER *ioc,
 	if (handle && (link_rate >= MPI2_SAS_NEG_LINK_RATE_1_5)) {
 		_transport_set_identify(ioc, handle,
 		    &mpt3sas_phy->remote_identify);
-		if (sas_node->handle <= ioc->sas_hba.num_phys) {
+		if ((sas_node->handle <= ioc->sas_hba.num_phys) &&
+		    (ioc->multipath_on_hba)) {
 			list_for_each_entry(hba_port,
 			    &ioc->port_table_list, list) {
 				if (hba_port->sas_address == sas_address &&
-- 
2.18.4


--0000000000003fe85005b140164c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQSwYJKoZIhvcNAQcCoIIQPDCCEDgCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg2gMIIE6DCCA9CgAwIBAgIOSBtqCRO9gCTKXSLwFPMwDQYJKoZIhvcNAQELBQAwTDEgMB4GA1UE
CxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMT
Ckdsb2JhbFNpZ24wHhcNMTYwNjE1MDAwMDAwWhcNMjQwNjE1MDAwMDAwWjBdMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25h
bFNpZ24gMiBDQSAtIFNIQTI1NiAtIEczMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
tpZok2X9LAHsYqMNVL+Ly6RDkaKar7GD8rVtb9nw6tzPFnvXGeOEA4X5xh9wjx9sScVpGR5wkTg1
fgJIXTlrGESmaqXIdPRd9YQ+Yx9xRIIIPu3Jp/bpbiZBKYDJSbr/2Xago7sb9nnfSyjTSnucUcIP
ZVChn6hKneVGBI2DT9yyyD3PmCEJmEzA8Y96qT83JmVH2GaPSSbCw0C+Zj1s/zqtKUbwE5zh8uuZ
p4vC019QbaIOb8cGlzgvTqGORwK0gwDYpOO6QQdg5d03WvIHwTunnJdoLrfvqUg2vOlpqJmqR+nH
9lHS+bEstsVJtZieU1Pa+3LzfA/4cT7XA/pnwwIDAQABo4IBtTCCAbEwDgYDVR0PAQH/BAQDAgEG
MGoGA1UdJQRjMGEGCCsGAQUFBwMCBggrBgEFBQcDBAYIKwYBBQUHAwkGCisGAQQBgjcUAgIGCisG
AQQBgjcKAwQGCSsGAQQBgjcVBgYKKwYBBAGCNwoDDAYIKwYBBQUHAwcGCCsGAQUFBwMRMBIGA1Ud
EwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFGlygmIxZ5VEhXeRgMQENkmdewthMB8GA1UdIwQYMBaA
FI/wS3+oLkUkrk1Q+mOai97i3Ru8MD4GCCsGAQUFBwEBBDIwMDAuBggrBgEFBQcwAYYiaHR0cDov
L29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3RyMzA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL3Jvb3QtcjMuY3JsMGcGA1UdIARgMF4wCwYJKwYBBAGgMgEoMAwGCisG
AQQBoDIBKAowQQYJKwYBBAGgMgFfMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNp
Z24uY29tL3JlcG9zaXRvcnkvMA0GCSqGSIb3DQEBCwUAA4IBAQConc0yzHxn4gtQ16VccKNm4iXv
6rS2UzBuhxI3XDPiwihW45O9RZXzWNgVcUzz5IKJFL7+pcxHvesGVII+5r++9eqI9XnEKCILjHr2
DgvjKq5Jmg6bwifybLYbVUoBthnhaFB0WLwSRRhPrt5eGxMw51UmNICi/hSKBKsHhGFSEaJQALZy
4HL0EWduE6ILYAjX6BSXRDtHFeUPddb46f5Hf5rzITGLsn9BIpoOVrgS878O4JnfUWQi29yBfn75
HajifFvPC+uqn+rcVnvrpLgsLOYG/64kWX/FRH8+mhVe+mcSX3xsUpcxK9q9vLTVtroU/yJUmEC4
OcH5dQsbHBqjMIIDXzCCAkegAwIBAgILBAAAAAABIVhTCKIwDQYJKoZIhvcNAQELBQAwTDEgMB4G
A1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNV
BAMTCkdsb2JhbFNpZ24wHhcNMDkwMzE4MTAwMDAwWhcNMjkwMzE4MTAwMDAwWjBMMSAwHgYDVQQL
ExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMK
R2xvYmFsU2lnbjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMwldpB5BngiFvXAg7aE
yiie/QV2EcWtiHL8RgJDx7KKnQRfJMsuS+FggkbhUqsMgUdwbN1k0ev1LKMPgj0MK66X17YUhhB5
uzsTgHeMCOFJ0mpiLx9e+pZo34knlTifBtc+ycsmWQ1z3rDI6SYOgxXG71uL0gRgykmmKPZpO/bL
yCiR5Z2KYVc3rHQU3HTgOu5yLy6c+9C7v/U9AOEGM+iCK65TpjoWc4zdQQ4gOsC0p6Hpsk+QLjJg
6VfLuQSSaGjlOCZgdbKfd/+RFO+uIEn8rUAVSNECMWEZXriX7613t2Saer9fwRPvm2L7DWzgVGkW
qQPabumDk3F2xmmFghcCAwEAAaNCMEAwDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8w
HQYDVR0OBBYEFI/wS3+oLkUkrk1Q+mOai97i3Ru8MA0GCSqGSIb3DQEBCwUAA4IBAQBLQNvAUKr+
yAzv95ZURUm7lgAJQayzE4aGKAczymvmdLm6AC2upArT9fHxD4q/c2dKg8dEe3jgr25sbwMpjjM5
RcOO5LlXbKr8EpbsU8Yt5CRsuZRj+9xTaGdWPoO4zzUhw8lo/s7awlOqzJCK6fBdRoyV3XpYKBov
Hd7NADdBj+1EbddTKJd+82cEHhXXipa0095MJ6RMG3NzdvQXmcIfeg7jLQitChws/zyrVQ4PkX42
68NXSb7hLi18YIvDQVETI53O9zJrlAGomecsMx86OyXShkDOOyyGeMlhLxS67ttVb9+E7gUJTb0o
2HLO02JQZR7rkpeDMdmztcpHWD9fMIIFTTCCBDWgAwIBAgIMGYbVrXj/AWDyoGFSMA0GCSqGSIb3
DQEBCwUAMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTMwMQYDVQQD
EypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0gRzMwHhcNMjAwOTE0MTE1
MTU2WhcNMjIwOTE1MTE1MTU2WjCBlDELMAkGA1UEBhMCSU4xEjAQBgNVBAgTCUthcm5hdGFrYTES
MBAGA1UEBxMJQmFuZ2Fsb3JlMRYwFAYDVQQKEw1Ccm9hZGNvbSBJbmMuMRgwFgYDVQQDEw9TcmVl
a2FudGggUmVkZHkxKzApBgkqhkiG9w0BCQEWHHNyZWVrYW50aC5yZWRkeUBicm9hZGNvbS5jb20w
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC5niRDfOcA/lFVV4Ef3caitEmDttFcfX8E
gCdwYxGiEDiO37ld/yjXb+HO8Y3Jk+dlVMltv+IdjiUPF+vr+J2NnRBy4sWkgifn+o4/VpUmBLhL
NW+bBYuIuG4+iUoA9XXuqZZNN55aelW0TperHdzcZSfhByomrRfnBUlH2Spvd/EU4DjW25SXwSF/
+uC6y31UYvj52z/Vzvqpapm6CKt0e+JFxTSdRS6Fsf+f/5/++IM51GSIrrePsCgrgq6S1S9kdKIn
Rag/s/0IKyxAQsoBcla5ZufuDE5ir/mlnYktkPJdg+kns/OPDsINSyWqNYE9PKy9+3cp/fItNFtH
krg1AgMBAAGjggHTMIIBzzAOBgNVHQ8BAf8EBAMCBaAwgZ4GCCsGAQUFBwEBBIGRMIGOME0GCCsG
AQUFBzAChkFodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3BlcnNvbmFsc2ln
bjJzaGEyZzNvY3NwLmNydDA9BggrBgEFBQcwAYYxaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29t
L2dzcGVyc29uYWxzaWduMnNoYTJnMzBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEF
BQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBE
BgNVHR8EPTA7MDmgN6A1hjNodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzcGVyc29uYWxzaWdu
MnNoYTJnMy5jcmwwJwYDVR0RBCAwHoEcc3JlZWthbnRoLnJlZGR5QGJyb2FkY29tLmNvbTATBgNV
HSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4E
FgQU1CyhXqcQo40SZ7kFS/AiOnRW6lMwDQYJKoZIhvcNAQELBQADggEBAFeMmmz112eNFAV8Ense
5WremClV5F3Md1xS0yXKqxlgakUJaOI/Fai7OLQaQqsEoxW6/QqWEi1wbZOccbdritOkL5b7sVUp
SU9OfuIlV8c3XMLaWSIluy+0ImtRJ49jDCI4KtQESHrqfQRZcc1C/avZvNED3U4b10U6N3SY+59b
fm2Vlwacwp+8ESTp49DsLcJqc4U/0rUZxLWtgPokzS+ovX+JAu8zx1SmOzUC4hj4Bp6Vnfd5KWUK
JJQBmQHXii+acSeTgHmPWUYs3tYQ0uIX0Yy8LUWPdGbEq+KWepzY2otC+iVWdngCCv8Nf1Xo1jki
AGJ6hrlWFE0qJVWv25sxggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9i
YWxTaWduIG52LXNhMTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hB
MjU2IC0gRzMCDBmG1a14/wFg8qBhUjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQg
/28biwAa6UIrFKBCk0T1Qevmf0FZ6967YjAfoW7Rk+4wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjAxMDA5MTcxNDUyWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjAL
BgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAC5u8ovLcADk4RbDFISk
R4zSzHS/9bT+mF92chd2R3/xlLzD37WfC+MEWnXvaBgiXEFkl74KAjQol5xAP3aDCpzQczr5ec53
54HjP5zYCQ2hQBekbXBP0nuM0I4TUeDYHz1Des85yL2dGPb3xglGhtB4vW9+1jAjSe8azibbuvAK
lzzkPGjq5lcM/QzIhIt27RuyyusYE+M7JgRrUGXjjbugRX0HoydhjUTTCFPfocAgNnM3jkhH9dBl
Zoj9tVwuCci+S7mUe7T3bcMgtPN4M5tl7flUinlD4b+uOeDY78Cq0vmsubhttzVGLyHfXBVTDiae
QK7ZhQiK7ewBTw/l9Ds=
--0000000000003fe85005b140164c--
